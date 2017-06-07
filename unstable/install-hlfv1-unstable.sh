ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1-unstable.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1-unstable.sh | bash"
  exit 1
fi
(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data-unstable"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f || echo 'All removed'

# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh

# Start all Docker containers.
docker-compose -p composer -f docker-compose-playground-unstable.yml up -d

# Wait for playground to start
sleep 5

# Kill and remove any running Docker containers.
##docker-compose -p composer kill
##docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
##docker ps -aq | xargs docker rm -f

# Open the playground in a web browser.
case "$(uname)" in
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �8Y �][s���g~�u^��'�~���:�MQAAD�ԩwo����j��e2���=��ojD��^��[��z��d_��2���OR�����I���_PE��Zq���8�S_j��4�16��Nk�/���N���V���H����4��Ӄ�����CF���h��_^����W����#+���7������r��$�W�/���c�8bo�˟@��_~I�s����e \.���J�e����Ӊ�ag���=���N�O�����EI���;�ԞG�����{������4B�����yNٔK�(M�(M�Iظ�E����OS$����Q����O�7�g��
?G�?��xQ��$�X�����/5��������ؐ՚�}P��	���S�4]h�(�H��&��I����V���l5�M[�Ta&��~ʧ1�<�j���@.6�&h!�S�J�MJO��<�Mt��h�C����@O�{<e��t�����24H���ֶޗ�.��P�Ȗ(z9�����tj��
/=���ѿ)~i��^4]�~���cx��Gad��W
>J�wWǏ׉=��+�%p��'�J�����uC�d�P���_������� �9ʚ���d���̐�Ys)n[D� m.W�����4̸PѲ�5K05�!�-sp��@"�)m�2{8޺�X�8T8�T��u�IY�!kH��:s�� ���"�s����� �D��P59�|�[�G���;�#F�`��"(�r<,D1�`��9y���� v0?�`����С�C�����������N�����5�(�r7�6�8Xs�*���f�b.�~�|������[K���
�4���6A(�(:}(( 2�T_#Bi���Ю/滑D���H���`��Ɗ�Q+S��_vЦ�6��0�Y�%C��#�w��f��9�[ݙ��\����� �������k�Q���N}��=/�����V�x�,)@�@�����u���(��EƤ����7+&@fK��(�t isy�1����R��(y��@����u��@.|[$�%���1�e�����}v�7��k�r�-'iKj����Ũ��,��Ez ǢϙE/�f�\�}X|`6<���,����i����X���������S�U�G��?�D��e�5�g�;���@=2̛흺_���@�8��В��X>̐#q���^B�Џ��
|Hʑ�z E�����d�
�{e�ޟS$y�@�|� �Pt%�ĳ	#�y"X�]2�ؽ-&�n�8�5�5�!���ĉ�����]9tn��Y���^�湘[��N+\�����{�Х��Soz�.��Ti�\OT�Z�@a����h�i��iʙ������E�r>� ����Ef��rB�=<�!�|-�t��������L^��B>J$��O��� ׁ��C�(��3�f&$���	I4��������5�/����&�f,O`@�Ϲ)��3��%��j���Ur(q��C�����%���o`�w���$���R�!������=�?B�x��e���+�����\{����c/���#$*�/�$�ό���RP��T�?�>�I���,��P6[� �H���0M���H@�.���Ca��(����U�?ʐ�+�ߏ�(���2pA�����IA+G�	�2�x���
� 4.�7�|x1�g-[�m[����r�45~��Ko�R��d3D��/9��g�A�ۑ���s���W����v+�j� �n���iX����4�?3����/%����i���e�Z�������j��]��3�*�/$�G�?$����J������ߛ9	�G(L���.@^����`���W�%��7kpl�L̇0�н�4��ށ
��*@�tb�I�7���txs�;��H��H�\u:w��f�z3�7l�k���AS�(^��b�.u�A��U;Ǝ�Y�{�u�9Ҷxd\�ǈ�#}/8���sr��8m�<	�Th��� =����4�+qz��	'�h>Cm��LBDy�Z|g����haڳ'�&Te p�� j��a���ЬG����l�]wZ����Ҟ)-K�z��͎���#JH;#)ɜ�H^�n�@B�<�+���z�Z��|����?3����|��?#����RP����_���=�f����Nv9��Z�)�D��������1�+�/�W�_������C�_�����Q��U�������t���GC�'��]����p�����Q�a	�DX�qX$@H�Ei�$)�����P��/��Ch���2pA��ʄ]�_�V�byñ9�5�f{�9Ҫ�l�m��Rx1�%���q�N+)54$wm'���ǫ{���(ǌ��v��7pD���������=n2�L?�SJN�v�*���x<�����O���ӿ��K�����;���c���������2�p��q���)x����}��r�\�4�ѕ���G�����˿x������wX��p���O�Z�)�2�Y���ň��ǶI��)�B]�B<�`Y�����w]7��%� p|�eX��JC�|�G���������?]D��� �D4L^L�ݠ�nci�x�s�X鮑&����V�p�e���+�au]��S��0"7�3�`��(�|�G�|F�T��Nc�[����&���k��3[��ލ���/m}��GP��W
~�%�������W>i�?(�4Z�B�(C���(A>��&����R�Z�W������?w�J���U�k,a	�0��Y�����?K�������a�Ui��U��n�/���Cw��ߜ�a=��%�~oh�A���vn�8P8��G`�t����t�v�#�|����mc�y[�ȵ�f��#<���39��&���k�͛#���L�-��%��f�f�����'�n��(F�|d���A7��:���6��9Z��=��nM]9�5�3ZV�y:E��ڔ�9��t��nw�cC��B�w{�C ����䶷�<����à�bM p"�r65�y{WW\����Vd���Fg9�,3�V�֟��A��߃ j�;%6�NГr�&{+~f��ni���p�5��!��x����/m�����_
~���+��o�����Vn�o�2�����l�'��U��R������6���z��ps'���B�ó�ч���7���3C��o�<���� o�2|�z����k����&>q[��'� �	!c;9�ݔ����E%qG4�f#�e�\k�-[�)Ѷw�o�T�]K�t*�1I�4�.�S��]K$�_����4^�=M��|gs���l��f��9r5��Z�lޥ�ݴo���<k$���Ž������Z�-Xr�\���������i4l����BEا���<{�)>R����r���*����?�,����S>c�W����!�w��S��_���j��Z����ߨ�ߕ�b�+P��s)�\��[w�?F!T�Y
*������?�����z��S��[)���	��i�P��"Y�eh��(�	�	� �]�}�pȀ�� �}�r]�q����V(C���?��BR��O)�`�PZ�d��a�2�f�����9��6ض��"o䑶hQ����hN�m�`]	otw�K��#`����;VaDI�1�ַ����0�k�d=�(G��b(���:�b��W��/v�~Z��(�3�z->�?��(�ԓ�/���/[?�
-����e~���~���\9j�id����d������b:��N�+���c���B��k��^$������2���Ej���8]�oxp��*�7�_���zul�������:�~��I|=���t������ֲI�ʭ�����x׵����q�"�.�ګw~���B��Bs�u> s^�ʩ�6X|=�&�_�+���x���}t_����[�⶿�k{��ӛ��µo�.nm�ۑ��]�+���Ec���.�7Quй��}CT� �b���>�{���ؗ��h4�·�l_�*ɝ��sG�w�:��4̮o��Yz���vy�Q�=Y��=���jmA֟� ʒ;�����M�7\G,��^d/?��-�D��n�Žyx��}�!?�������o?����<����/e���?��ǚ����6����NM��t>]�7�4�Z��d�qb�'p��p8]O6�u��~0�I�^�=<�D:9*B�GJ��O�����G���-��⶧n��z8���u.R|Wo�&�U�+�7�H��hȊ��أ�*��o�t�?>m*Ŝz]Y5�m���W�'q���v
��%|����������wu1�[�9v���nl�i�YOb�֮wm�g$��o�1%Q?#Q����v��(J�D���]o�@P �iQ��AZ4A��@���C��/m���&-\E�:(��!��őF�h43�u��#y��9�=��s�ݡ!�B�>���'�l2���29��N7�Ub"���@2��w�ld6<�r�gD'3����d:�)(m��1�aOB$�'ےN'���tGF�L�4�n�`$���h2.��#"O�dlr�p�	F"�q���Y�.\�5M�E���s5(�\�B�eI��B�0S� s�%^C0���N��ISӴ�
yr��i�$C���a��)�&1X�H2����l>��1Prn)(��|�m��)�n�P%p	��H_Co6����i$$&Y
�C�7�<l4���I!>=|.y��l�D4ze��Ke�6���ʙZ����|4%>�h:C>�h:���8	�΍d���'�S���~��y*8��i@oN��f����<�}�h�l���m�<����>ǫ��5��(H����XT����y�H2;I�CV|�l�;���`-%�C-���h"��^���45q�sS_�7�6���+�)ʼ�)Be�#M���(xE��4Hh��!�?C�ʱb�?�� 6y�웵
�I6��f�%��<+hYA� �pL	RGn�DS4���z�з�m=�����U��A�1�(h~g���w��
����h�?�g�
JG4�h�1p��c�F�8˅l���m�L�e+���m^�v����r1#���s��3�kVR˗�8Y����:܏`�׉�8�/ì���ɧn<D�3�������{m��&��ƪ��u��xkB��.ס�_��pX�����+��R],��R]ƃ���N��3tr���X���++�`f��i���9��2�1{�ྟ�a��^�S��p[�?�K����*e�+Q�4���S���k����p��O�����w������ �K�Z��j2n�x_n�]A�ᚌ+|S��8��Cv���(�^�m��P���M_���"���nۃ�nKȶ�xY*����W��&|C*�%|8G�[*����o�=V����Jߨ�o��O�
ϖ�F��0�|Ѹ~�L3!�$����x��@Y���;��3�ꙭa�V���˿{>����/�$�t,�q{��_�%�˿*���mW^Ĺ��S���;~*��I��Mǭ�6�%~�*�����(�e}��/���7̐4���<3X^��.�i��yK���p��O��:��|�%��w�����v��E�O����@����uy-�?�p��.��	'H\�ZM8��"��eI�+BE�	޵����X�s�0C�9�g5~d�1��N�K��N�ך��O����;̐���<�<�?�rz��k�>�0��^�[���%������ þxز�V Y�c2������NsmEA)@��9MV�च@6����ѝ�7 6�F4��c�"ݖ$��}�ʝ1��P��
~��W�;�st:M&�{w�[�QQ%`,L����%��^�YUm7QC�H�C�+�d��K�u_�yi��Jʵ+��`a+¬�f�T:{��U1��d��N��UvVY}i�
�o�aВ��߸�K7[�֯�^9����7o�Wff|����o��G�������'dgq��,����"���˨MT�p�N�jj��YZ���$�Mr����f����:}˯�{��Z�?����u�;,��G�����X����\�q��4���?<n��C:\��W7i��y.a���2N�QX�����+�����ju�(cl0S7�7�������ybM����a�rw��o�E����5/���:�2T7�����n˓��ȇd��>}8����W�O�(�H����o��¯�I�GK��#|��*��i�af��V��EV�g;���p�&9���K�x_m�IW�"q��9A�#�?Z����j�Ҭ�s�����E�E���:����ʿ׺��\�GW���6������6���g��V��XĨ\���s�O2�"� ����R�
�E����`{�F�؟4��!�N<����2�aOn+�:
*.�]�yV:#%�������?�q��N���{���\�G_��-�'��u�=a�v�k�e�6~X����L�t�v�2lH��xi4-���l�W�p�m�H��EVA9���-᳍�w�*�|k�WX����;��;���^4S��{<7|5<RdD8\"�7d|b�:��ܱ��u��&٦�C�ٖ#sԂc�ZX�:��Q:��8l&���&j�Փ�N��L��'pd5'
O,,<q��C��ܴon~�s���)'�c)�����tX���K����3]ǟ;�;I�c����u����rz-��s	��qp�W\������_>l{���_/����-�-v�%Jn�[�zI���fyr�u�J�JY�}�2����HFt�B�wa�>������_��?]����w���뷾v�+��%�1�Nd����6��q.��6���pp..��sk�,�$z|�Y�w�ž����?|h��F~�Piax�Q~\�N]`������w���<T7R�L��2�h��6�	t����:��N���'A��-@A��3ax`>U��������#J�c�Ll����J���$׃���M��v=o�z����y�ay������j��~Q��6|�4��UB�P��P�0ȑ�L=W���Y�����MEj]��R��)����߿G�9������|�=�b�t}5�陵,���D��=��R#�Y��� @�V�Q�z7M��j0���{�Lc}�Pu��^�%Գ�n�o��jr�;��&]}G���jB�ރjV�esA~��);-{����cT�.�u����MX�MX�MXǹ	��B�-�ƎDXz@��7B�(����DWȕ��'`��Z�� �v%��+D�B+vR~sW(G<��I�%-�U*r��l�q��m��)?���U�+5�UF��E2T�Сl�I�b��r�Jک4�.��S��A-�a}��Oا�����`
Y�vx�ꓽ��$�JHm��V V*�b<��x�M�'�nJ�)�ʤZi��n�xנ�U�̈́�Δ�|@΋�L�rփ�/��-��g�,�c0˶3���釪��^ܳ�)1�^g���өܠJ�*� Y�8)B������R��ѾTk���x��`˒'�-���,Ŗc*%29� ���ߩ��0�T��H���"����,�E=���B��G)��[���gw��9��M�F:���®{?�"{�m¯Ēa�K�6S�\7_I:=�D��UZ�zo�%:�Yz3��w4�ԏ�,2��S1��.s92rzYPM�j}�L��j{�6wKy���m�y^��շ��T+R���w�Ġ\����O:i"*6���嘅�%1�SnR�*� ��v�L�KS�r�x�v.����v����۬"���R�3�~���B#����l���p讂���}O �S�
�ĜǕ���p6Yc�a��p���v#u��,����,��x:��
����H�H^4^Q��gW�ְ��}p�k�c��J��\�x�^�pH���8����qV�*ͣ�Kd��<���ո:�Nnkؓ�#�a���TM������'��ǞOPǷ4J�/מO�6�4�j�������XV��^R�j���U�xH�E�$��G��d��}��V�z�ĥ����j��ƹ�=��I��_}Фy<�G��+
e���g�� �fw��g6�Ic����t��^�V��0�w�b?��aE?.��F@���
:<[�l�% �ú�}�+��3��^�A������U짫���gM
�I��'o/�#h�撣�;�H�@��)w|y`+'ѝm�v� eu����LJ��p�������20#�Q?K9C*�/¡�����yƟ�=&����t����:[H�Kc��1&;��Gg��l�l �����*�`�&� Y��LN.�Q�.
�m�dP:>K� �h�ƨT@�4Ƌ5&t��]4���t����� �.6z��[q��/̊[2�E��j���8	a�ֻ[!�]M����BRj/G�r��3I������\:+��p�ߪS;zD2��T�_M�g�荑��J������t4!��O�v �t�3�����K���I	��T#�N�B�4���a�t�r����Y�)�v���9������^_��-��F�~��l�b��#H�u�y��>Q��tVn��$��n:�ۏ�%�pX±@�uhI/`��J�gƔˋH2��#��1S���=	���vьp��4,�B˹���F����v���<˲�}|,i�D2c���G��D�A)\2���l�7�@���8r0XL�r.*�)�(BMEF6pR�ȨT`h/֘d���èn9l�Ɛ��l%|���~��ž?�ܡ����r���"R�~�M��;�\���� ^luB�FP�9]mJ�;���y"��ގHĢU:�7����e�!��@�S��A���|հ��5y-����m2s�G"���o���!MĴ��n$��B��9�UO,׫�ŝ2��e�8;��T�����=��-�{�}'=j�m���: �Άx�X��wڝ$��{�*u&�%�p�o±��㜴�K)s.��M�8���X&�c���6�Ӻ�.�jl�Uk�T�hJ��ڊn-\�?�#_5,�T���ʫ�՞ �M����W���(%VeX�Zðp!��n�Y��*/L�QQ�`<�=�}�Ts7�����/�������E����������_{������GU�*�zS<�k7+L���?g�lt�?I�!�Oa��y>����|����y�'��o{����^������o~5�G�?���q�8��8���W@x��7���E��J�NT(ckإ����/\�W� ~����n�����_�&��x?��s��1���۰&];d�vZ���k��&`�	X���*�G}�2H[i˵�r��\;-����>
��K�[��?��K8U��.��a�4�6y��,��Q�3p=3{�;�����CΟu{�5�]��3��:���ZJ��R-?K8,�g~'�<���y83����c�l�iZ֞��j홱�X��=3��ޕ6��d��8�_��&�"���o�~#$�wt8��#�*j~�Hb1��z���</��S)���佹��4���|b��'��D�3緟=w���G�m~��џ���g�/=d�@��H<�^�y���no��D��$�習8E���Q (�5�O���
AAh�s�R��܇G��k��T����r`[��@���y��{Qk�{�Wd�Ǚ8�᩻���a;�ϸ�I����	�v���)��2���[1�ԭr�Wt��e�_�u�թ���0�zn�[�f�d������9:��*�)�2jR�����:������"K�$�"��"&B,J�$I)O�(P�V~�μ_1� ��x11������̵^|e:؄�A��{����[��{w �S��~�ג��Â�#}������T�7�?y�nU�X�O9�,ֹ�SIj4�2'u����܅�^��nHYl�+�lߋ��Jj�A���*��_��s%߼������$���`���]��>�Yj<�y�)��wUK߈Y�Kmߔ,����ܱ�O�E�B�|֑i������ͧ�+�&�5~���G)����y�bx��*6v�_�z�=���'}`ߧ`k��=k��}ر5�益58�Bs;)���`��M�K$���󦽯�'�N�b��)a<���'����$�k��l�͗�!��7�v~ӫ��W����2_�'�#򭦸?R�,�Ӹe�������ip[�یP�H���t���a�o9.�Tl�^Lw�ѝs���;��_o�����N/�����m�<O<�w��;t!��W�Y)W�����|��\�ѐ�O�z�$r~k{�=���-I���?��K�^�J��{�׉�4��EO�	8h�/���ހ�޸��xN�)�'<s��!��GB��xly�������4qR���ҍ�Ӎ���G��0O���Jjj�ͤ'���!N�ug�_7������d@8;{���'��o���4��:䷅�C�^����c�<醩,��_�S�Řy��ׂ��]RaՈs&DO�����q��ޟ6�N�o[�=G�g0�_q�4tcfLu�ɷ�_�`E��}�M���lz�C˦��1�����Wot
��stJ��)��@��_��}��N�{`&"\=�wZ<J���?=��Cb8�)
���?o�Ҹ����HP�Qৗ����Ӹ��Q�A�G��+�m��q}��~ ���;�JִWLߑq�4���²~�AI��. (J!��R�/z���߶,��x�]�7�W��S�<�o�Q��'��w6�G�D�?���?
�?
D��#c���m�� ) ��?n��h���I��Q &��Z�T\C0]�qJ�4BAi�Fi�UIB�u�E(�@H�@�"LST�"5E�xr���~3D�����E�D���F��]S"/4��n�_�(vw{����DQ�k����6�rm~�5�����څ1�.�L����o[G[`�`ˏժ	�'>���>\�F��6��QtREd"�:i�n�ָ����2����UK�Zvv(Dw�nH���D*3.%K�Ӗ!�k?�����5���"	�?Jc��?��(m�.]�s\�'�������C��?���G����lkU�9�=� �%p��i��E��T3�j�%Ռ�[f4H��������/
Dk����?I ��������za�'��q��I8������?	��(��/�i��g}�rO'{^��*�站�$�*���'á�F�<+�l}��uh�Z��k��W��rv�^7��4��2P�j�a��v���l9t6]��r��^�WY�(�?����/�j��#wrWke3���}~^�8���.f��'Y\+>l�N��Lu�Jf�^����Uo�jm�6 �3˒��e����9�W�6����7Tfӆ$w�GkO�4���Qk4�.��d^ʱk#O��.0���2��J��l�0�EfހTJ|��=����/���.�`�'Dk�i
�����o�/	���g�H� ���0��$���������0��}��`��������?q �������@�#6D��@�#i ��?n���!&�'�6q�ݤ����8E���!hJ1	�EL�LcU
�SCI��
��:���IH��/���W��Ū�Z?�jY���:5V�S��w�F����F���B�7���Rs�-�]sH�s�,߮�Kƛ�ӂ���-��|ad���`rx����.��Fب9BS|�eV�[,��Iuf��ZL%e���E��������G� �����'����G|�����D �X�#���������������I���������!.�?	c �!�?��������P���P"������8��������'����P�ZB���Z��E��53=m�iR�9�L�+��@����Y?]dG��HosEx��6Z�ԄT��9I�݇:��zu�`���7�z�ٚ����Yc��o��:�����ha�<W	����b�qg.P$	��q���^7ej�|pI�ͭ`��qgo�d� p�/tgj�詽>��_���yV"���4δ
|iT��θ�_T�^Y�L���$��KMeΏ���z��=�Z���Y�j��2��Z�Ӫ�x)_j�mA�Hq&N�^G�t��su.��x�!u6g�Va�����H���?�C����H������$�?�����?��O
������ ����?�����_����w��1�����`���������G��	���`�G`�������O�����"���_���B���h��`�I�J0�f(&j��j�fj8�0,���0*��i�(͒$� ��/G����wI�#�_�B����*"?���rWxl��S��QW��J��oj�MU�«�(�4Ԟg�ҴlSͬ֙,��2������M<����ڲ�U[�U���L8$ǳf��=�~Go�%{�j5���_l����K
x�������H����U����q�OP�Q 	�?J^���������3X�PDQ���?��� �=��4�Ǆ���(p��  ��7�cȅ�@�#����8��������g�?@�3"$��Y�Y�a1�d1UURc��P�]#XSt��i��5M3qg	�4UCa�@�D�g�_7���?X�	���� u�qm�]��d^�Q�V�X��	�X+/��䊋�Q�s_����hB���t]�gT�^�����m�.1bf4�����'���H���ֻ#�-�E5�B�e9�xM(�u�֚aJk����六��C���48�)����� b���w����I�����G��n�� �%ȗ��|�����_�`�����չ҆�K�Y�2��]�k��9i+h=J�!l��b	����UЉ���5��&����\{����扽��*w�M�cm�^C۝U����Uy�mdA��XY�*~��[�C�&�+~��	u�7n7��ۭl��̈́��j�8a��dܗ�]/˅��6�D�>-��Iy�a�%t�j��W۾�ؒ3R�G�J.�y1��~k[�	�-Y/7��gy3�Kt�.�����Dx�d�4á<����nK�;땝z�Z�Kq��R|u�����`�v<V�6tW$�c���in5"�c�HN�n���"�=/���gN��w���mܦR��2?�A᮲^m��3��Td�J��)�Va,�*����t��!�eu�q<{�W��!��@d�2"7�(Ԉ�UZ����B]��G�˨S�����4E�eqR�Xs&��<�d�m��j���du��^M��t�a���r.��~��a��������������_"�����#FB���U0���������i�_���]/��U�]��d+�9���t�������壱�dl ��|T����a��Q(/p���������y�с�沿Ik6�][�%�WDn��9Ug��r��"W�6QTV���3����0T��!3s�|������9u�d�1}�5ʳ�{�A@/���y[w���?u�9��V�����]�����V�2�[#'7���\oHO��j�8T��T"�n=��Uh��r9�h�����damo:�����H���\���F�X�?pD� �����������@�+$����lH����c����`�����5��@\o��$J �?
$��G��`�'"D���u�`DQ����8E�? ���������?� �Ņ�B'��0�D)F�H���`0�DgL��iGp%T�d���4SU��)_�(��������쿯���\hgi�Yڃ��K�!z큮�e����7��T�U��fk2���\4�J�UV]��T�J��I���
.u}#*�̠�&�b�k�*��toH��Y�le����FYlPE=���Y|��ۆ�����e�Ɲ��H����E���O"h���$��?au0�U��C�/)q5pS�4el�M�mٿ�f�`ꦔ�8��e�;w�c��[c	A�$uk������]D�7L-�ngۊ��E�E����X�n�~R�V����?*�����Q�d�����cIB����Xɦ���o�|�n�XS�(���]ό���M���m�~~ۿ��0�����=�I�q{�L��ᱥ)���4B"7�?è��=CS�Ǻ��eTb�Lp��I�?���1_�۪�n^Iv�ʇ[��1}������?�.um��Q�'��ז�2n�%�����Wd��5i�cZ_�KqD����M��$WEnT��1[�e�6�0A�ӥ52�/��E�OȯZ�����Mޯ!���{~��S�ަ���Rc���zʴ��7R�weC�M-�;$5���4Ռ���>���SK��L��p�D(?C�?Q������i|��I�i�N�0�}@�G�O�����Ə���G�}�
��#���o\����g�#�_����k^룃^1���=[�$�U�c�gkc{\V�zەQ�ݳ3�����eW�{�5��WKuuuuuWW�ԣ_�H�(R�x( �?��HćE��"� ?��l)"E��#$�#po���1�l�T�VS]u��{ι�{�^�0J\_(}X4O��@����k�����N��x,��MOC>˿� 5��T0�� ��*|�"t�*"z���xv'�q]A�-wʣ�/T������y�^G�Ņ|/�7���׮�|�����O�_����kM��{���j�"�A��}�f�b�;T0���ЊGB-"@�	:@�iP0���\�Go~Fy��g��?�_y�]�������_��k���?�~/���EN*]�j��u䩢n��?\G�2�?��@�}y�^B>o�y	��Я�4����8gQ3Jwc1��鋚#�r�]X�Lvmks���6��s�(ݡ�*=�w3�|�7*����g��.Y��O"qrn0������߳�����v?�ۏ7�x�e
_G�l��tl\I�|t��w��i��+�~��5��~/*��Z;y4D��|�v0��#�n�5�i�ɓ�p/F�@3�ݣ��d�F���2N����0��ӣHGf��|5�O�όJ��(E���`�3N{���J�:*�ͽ֛,��� ׭�FY6�;�u�2m�6�����q� �J����Z��	��� /���x�����Y�{�7�9+��J��~��p��Z�fZ��61M��dĴ�:U����uR��{�&NvFH�~˺ێ�x���t�TS>2�d�mқ+�T�|S��4t7'�c9GÃM)�߯%��z#6/�*�Ov*�d��K�
|!J��Y�di���D����<��J�BE� S�,���aX��J��M<9�wv�8�KIY�7�l�;h�R��^(է"�$��*�A�n��1��v�_�v��B��|�R"}�x()���$��T/ ,�����p�d���\舖�"2��}���K�)K�ڣ�� \��t�Uc�&E�V����	�~6Z�e;^�%�R���`�F���儅,���|�gS�D}��d��|�T#+�� ,s�3��
KZ
�����_M�1y�d�B�w��H����X$r�|�$4a�L������?��Q)[Lqab�_j�F�v��:c�=���+,�e�2^",㳅�{aI�3#��%��]�'��0���lgB�S_�U�r�Y����0Y�ʑ)A���ѾR��m*ף�����{�"|��D���I��������Ҟ�\i�%bAX�g`O�R|NCf�KI�8�J,�M���A��Ũ��|�}�,Rb6{�t��r_��_������;T#EL
�@�@���u�gs|6�g��϶v���m��~䩺�)�$�n�����5t��>��g�Oا�V� bܡ�Q�~�Vf}�^f�1{Ue�j]����"��R
݁�l���ϡO!O��޾l���<�kh�(�<GO����gI�f
���õ���czL��Ȋ�i+�2�b���x��*W']E�!O�"/Z ��u��
7e�O�7V�շ��q�0���sn�Ϭ|E�߫�[0��g��H�jϵ4��O�O��Vw��Yl�`�v�OÃ~�r� /�
߹�~��-�~]# �@wDi./���MA��AQ����=��+a�!_|N���x��*�o�'��I�3)����s�n}㱢��X^H��Jk�Gc;5!1��V6c��c�8�:yK�c��>hh�����5�G�E7;��p�t4��n8fR�h���,�B$F��y�dF!
L!��1\�f7��� �TjIQ���_�I�v�B/<�	9"'R�8��$� [���"F'��a�_�m��/��a�{0���d@帮�D]r�7����([������$�6d�����2�L���E�X��U�ӣH��
�H���'K��Z�$Ce�V;:#�EZ��`��HR� !�^�[�v�д�ۜ�'�ԯ�0��(�F�����R���۬G��i������8�`T�0��ʱ�(���r���zO��W�O��S6�����^���.X��<;�" |�V�i�U���5=,߹�o�G������|�l��H<,'��'�v�A�b�P��D�H4z�DK�n$HM"�����3Vyr�U�r�91c"�U�"&U���eӬ�}<�,�����������r�x2�O���It�=���QJT?����o6�"��`��{q9���(���dJ���=��f�D�n���B��CNb!���YÑ�pHG�G�%8�q՟�����P*�����o�� >:ht_�ek�v��k�EF��Ӕ��
Dv\M��D�]�>n�S�S��I|ߋ�7�$#7�����:,�^�{�d��������r�S�Ky?�و߅�2ߥ���}]($w�0��6���S
���'�ERiE��h�����Y���$[-��eF\{y�Ȧ�j���-d�@J����(��\��I_0�����+qTH�'��яYn�6bev}������� ������������������ux��������ws���
���H%V�B�iB9��s�?����!_���|$���}���'����~x�����n��{���|�_��گ�� ����@/�|=��N	#/�<���_i��7`�8ݡ8�k�k���~���}�K���?�s����~�7~�k����Y���?�R;���~0���}'��I�tR;�4'M�I�tVq?꫸N@�	H;��Nj�����l���QH��t��#��}��ʋ�����1z��-P}FF?�,!�,�CZ��!'��<F�~.��/n���R�E�<ǭs���Tg)��3p��Q�-��
9�W�x������3��<-�'��|3�|�|�|3�(������+|�{�O`ŗ9�v�����m�t�Gb2���/���|L��\��
��]���-@�H�<;�� �!b~��p(��>���`��G3�̴0U Z��JO(�1�la5 ��ǋ�!���j}�.D1U�OM0AT0Uf Nƴ��14A'h�:������c`�@���P �1 ��v@�R (�6��FJ#�#J,��`2����Jbl�x`V1��/'��6'�/�4�<5�D	�X��<��-L�ʈ�����E������$�� 8F	�:Y�2�u,JV2�-�������U�N��d��IT�b��L5S,�_I�,b�L!��1�[�f<�$���dZ�*3C�y��<`h��Ѡi�R,��"�p�0R��a�ʀ�D�s}NяpZl�G�Z}��uAxt����=��n��2�(�˶w���-�ߴe��u+XG�3���k���
w��Li�dр%�bV 	�O����5`��"�/:���0F��@F1�̛ޟc��Elۉҁ;�U�jT��kV����A��e�c&ڙ��@������0{Ұ� �em�k��E��(Щc%�=q��ÁE2 ��1�=�DȬ����a���T7��cK{�p���Rx�s��֦x��6��nǏ �=T��v�O#㆒偤�< �{�oa���f���QQpm@k.(i"�x@����P% ���` >M	��W`�1�dP���Y<.��K�l�{�KZ9U��� ��h*��`�mw��ۚ��`���ڀ��>�&%L��a���$Oz��$����7�ڷUA�	�g,��Aэ%����t���x^�6�Р�����W��6[R� ���G	-L�p��2���	���&ΚB�`F�on�'Qu�3`< BK%p���g��ʢ��{�}�}c}��M�o��3eZ` �۲��E�2��b`�oJ�I��(J�[Q���AO�!��"����Z���A�3�{�8Ȝ�/�5�0U� �\x/׀�.��`d�����m��m86I\�������m��>t�_�w<�d��e�Nm�ܥl�s�N�����l����_�1�m�\(���@���%ʓ��ӡ��H 
�be�76��	����b�@��m�w��6,J����$Z���o�n�`�/?��l�j�>{��Y�N����!�5W�y��r�4��<�_@��gW ��4����:>����7KztŜٯ������/����N~�5P����gڔ�+Y�p0�юs������	�hN�C��vk�Z�:�.cx ~Yx�nx�v�$ӭ�CtEmZ�ױl���Vl�

�O�Qa�3**�6p�&#H"��yt�pi�p�樳9�Ĝ��������<����fS��VU���\�Lܭ�ٲ*�+��� ɢ��sǼYTe�i���X|�U~G�3+CK;Jo�ݝ1h�w��zx^�$)��'�zo���R�%<K���7���
E��|r�/t�$�4����z�-
#�h����^�
�1�-�z{�Џ3����V���"V ��W��-�D;o���e�{�{�u;�,�<����<�mRTY}ޥ���*e pԌgͫάA:���`�N���~�#>�{�*z|u���	�NJ����IP.]��#��9²�8{�`�*l��"Kx��hTp|�D����;��9>�z_���h4�Ik�bk�ӽ�h�PØy�N�0ޝ�_!�;��@����7-�}�����r�N��'��^&ƻ͌�]*�D��y���=Ϊ�#cڣ��-R�/���fص/�T`S�E0=�$
q\Z7Wü߱J��7�@c	}U#�|���;C� ���B�a�R#14�ZL���4�IA�����S�����W�u�H`o(�ޙ�Ԧ-0����p~n)�X�� /�fs=��	 �k�0} @I�����ٲմ9j��67�KޠY<���h39�N`���$�16j���C��F�z�V��T�7��!geHoK�G�C�iJ�`�D3Gj��G7��'b�TAS(#�	!�I�Z˛*���]���G�E�k?��Q�f����b��a�ޣ�>�T�g�Jz��p�<C	� ���� �����P;���<��pz�rola�O���<H��s-�c��U��vGF���86;��29i�9`���
�����Az-ZA0&�I�@0�W䁁֭��`0T9�ȓ�0�,���-k��۸�0.�= ���Y8lN!d��pr�l��/|3�jK�B3� ���O_6_1 ���'��M�A�:K�=�\}Y�ʋ,�W}�-��,�H�����]�o�H����W�i雞�t��m�~+��	Y�V����H�oU�s�;Iw�G�g4
���\�S�Q�|��q��Bq��~�q��E��\͡�]?�rݓrb 
��ס%���Cx�jJמ�n�����/P�#��{����'64��Jg?� +0C�sa@v�Ke�O���E�k�1��?���[AwG-	4{�tpѷi]v� /+�3K���i�
{�8�:+��T�P���b��:��%@+s��3^y�mNHx���;�L㻥���WԪ��A�]*hFkq����*�n�P,�?��u���ٶ��B��N��;����vL(f/�;<���D����v��h�z��[�{�!��B�s���BUr�H�X�Ј��W��n������^�~.�?/-϶��)��͝�%�2o{挷�:\XEg^��[�.�U��R���ppe6�� ��ݯVI���0�Sz�^h6<��@�!JɳZ��xW�U�֡c����jkDu�>6�0殛ϝ6���=�E[f�H���HTR἟�r�33�ŉ�f:ߩ|�X����#[�DV�+������O�����D&�L� �	�X�eϑ���1�x����V���b�^���K2��?�c��/
��_~1���`�!R��X�ЀKT$�람�[@;���0��7��E}3h�~g��T�%�c�\GB���ǳ�/������dA�#�6��|���QR��@lo�U�K�ߛ��%-�����&�O��������W�<�0������N`8y�r>8����v*'>B1A���n�;�!��u��������=���Ѓ:�����<É�_?t��'Gr�M�1���@vǳJM��=zI}m�@z������Gt���G��%�V��̀jh�m�<!�	]#4�G|<��V	gd�g:����Oo�Ɩ���K]����.E
���oG����(�W�^���J�����U���pv�yu��Wo�B���oֺLf��Z@q��fl[s)�>`����1DJM�Cb�z$J�������z��$�?��m�}�;����d�}�
��p����cb����W��d���ϠA��	s0�z2��{��h�53�cX���
Yۂf"��;������"���~��$	d�w������ZI�֒�ό��f����2@,v��K��u�+'}�R�w����k��u���q�H%���+�\4�W�O�[���sH�����֬�q����c�N�7�Js6Vm����[;��0(�S���"����z����6�`I�/n�]����!A����/�j��T�]ِ����p�ρ ���C�|����
}�&k��������
�0�xrE�>\&	��G*Mkq"1�/�'��}L_����~�]�D\I�\�4�m�>��/�['<*�b'��`��)A9P�-�8a���\�a��>�Κ�BDA�!�+�@k>۝�(r�����'�9#�Ő�r��5�xz�ڷD�r�	nr?���e�;<�R/�B��
G�f*�3��3���xf�3���@�������=�Oof`^z��8+���kv�۷�����u~+>)'V��p���N�Yw�-ζ>zȄ�1.�z0̐�q*�q�2?�/7<��д���6�x�z���NB����0���ȃ��TL����~^�/�CX��X��8	��E�N�%���i������*`.W�ܟ���`�+	���	ǿ�4D��i0~�C��mk�5�|��� U�E	�1��5�1}���$�l��.H��+��l��ڼ�dv��-� H�O�O�"ù	�:,�mvf"�������2�Y.����4��(�+3�Y���ǂ������g��$�l�td�K�ϊ�8����K����pz�k(E���#�]��1��N9)��ڱ>{����F*p|<�r���N��3���!|&�z7PGs�*4H���N(�Z��6 �$��t��5��b��_���G�I)������RA�Q����X/��
N=ı���;@v	�qY�O�F�_Ήg��࢙�Ќ�,p���5��G5v�[_��v�����?Q^����,������3Kr$��s4�[����������/Ë<�����n�(��0y���i��q�G��ldH����!q�G���}��|XϿ{��O �����_�⨓�@RGR�%�T����|��������OhK�_#.bD�(�����c�� ������������X����?���H��y���y��Q�f�ϓ�F��FҺ�3��i)��y�⹌ʦF�2$�$���sl��U�X��H#e���Q��S!*�y�I2,u��8�W$��%��m!�hI=�#&*b�?;��儦(Jim��ݬ���ܮ?X>�Ls�iR�<�{�dz�ͫ�qζBG ��'���7���<V�����Gɪ4}����MQf��S��s'��鎱3��x�)�w��+]�0�Tsזf{�N��f�J���]#�����G/|ƭ+:����O�������z�G��Q�o��X�����������	n����o��üu]|F�@��R}��4��� >5���OM�vj�Gf4���G�̥����_�Z�s�C���X����_���/��<��?
܎�O�c��������X��?���	��U3��[Bm��C�T��v��b�I�VC���a_�X��~BB�)��5��-
5qM�~�B-D�%������"�+ӵ|A׀�/��v�&�mn/���a���-�%Dτ!��"��.���N5g#��w�W]��L[��H5k��m���W,�X�,���SWt�%��rB�P�y�����[����r��]���rQp�C��7�f)��ya�8��֗�M��ȝ"!4���n	nX��ɂ�V\��$�k��%���~�S�@���A��&�D]c�6Wn�r�1�w���h�w�|�ܖ ���,�*5�����=B��l-�f�ϐ5wZ����*��T��_I��|Z��iv,�v鮹?.�T%�l*'>.VC����爃�G�W���X��Q����X��	�����8�?M]����D��c�<���o����������8�8�����Ga�?f�����D�X�?��q3D��8�G�+��������?n���?kp��a):�8%���c3�5��9e�"3�g�4�eT�持F��晌��8��/A�8�����JC�� ���=_�;U��og�]A(�d��������?VRg#l*��$5z.J�R��ۤݹ>/ˏw��#�_���ڛ�"����S��	SzڙR�9��[cU)��� ��\R�C�㽈�����Q��8�G�����=�ǁ�q������� � 1�����������������_���/`��s�q���v���\�6�!�?��q3�.�����7&*ǘ�j� 9ZnLV�@���w'�X���X��c�����}���P�+M�+P�f�ZN�䨞����1.L���*�}N���V�LV�ԗl��zl�7��>�r�U�t́a	�G�,�Fἕ,r�hY�h�E�#����j�5�"��$P}�e׋����D��-�[y��xC$W��g��r^s��BmT\u8ʬA��ܦ��Xb�%�4�v˹광5�O��29�4Ú$�a,
f��T;�27}�ݙ�13�fU-���Y�+��o֟��aN*U{5;����͂�$e�rAw*ŖP ��#�b��������������p��x���[������í�;��X����3`�?��c���|$�k���]��S��#A���v������#�����a����,�c�����q���ԕ����	>x���
�2��Qj����RSi^3�5�i&���@c(2�IQ,�!�j�������r
������� �]��A3X��o��QK�bn�\�����)�t]���g]-,�2�o��i��_��A�ȶ:t��/��c��=�����������d�Y3]���+ڦ�5��H�y��7����e�Qώ���1�r��m�������oٺa�S�i����R$��F��i��E������#A������?���x�_,E����Y����#�O��9��<��H!��.�?�q7���7����o�3ܘ��q7F���h�G�0�<���u�����E����'���ЩA�VUEa���e8J�9R�R����@���iڀ0�Tz0P%��v�Q����^������-�y7��"5\�9q�m�w�
m�B�ں�;K���e�����.�Ғ��]K[f�L�%Y�j�y���S�8����%S�7j�oIҰ�dE-n���v�L3_S[F�����Dia������.��<>�)�x���A�X����,�����?7B|�?t��1���{����p��H��_��K���ZBu�ZJ֠�O�T?/tz������������X%���zˆ*�$�b^h{X���={�㦪�+�MU��f�f�����*�(�䶶�r^e��/(��\���pM.����P�2�wa���-���l��.��������Ts6�[}� �{%ѥ:��԰5/�T����چ�.�W2�+g%TG�V�����O
�������D�jm��Z�"�O=i}�d;w&c��I:��H�(�W�ڨ�է�'.�֜V��$7�4�r�I���	���fti�?1��|������bD� ������� �C7;������Z��l\i��rnZ$Ю�as��ek��6.����sGX�Y~Zo����pW�>�즱�:����C�!	?@dI�gEa�U�)�S�w��+�8�l*Ԧ�.<;nV�;9.�T7Ƹ�w-A;a@���[����A��x���M����˻���)=��b������B���n���8����[����8������+w�����2�GrX������>�y�4�[��2��zՒ�v����/�/��rP�s�E9d�OlD�q`����1[��D)/(A��3���3�s:b�ٌ�w��vVaC�m������q��v_�5;UQ��џԲ�Ua�'��L�G-5�i�s;� S��mϟ�ڢ��� ��!^���o��O�}�$��[zR5S�Wy]�i��n���ܝ:��rZ�3z{̺Ұ�k�+%ߗ��rպ[��b�V�E%���;�9��;{�օϧ�#�ue�>�1�X���A�X����_,��������1����b��c��̀�����������O��?X��?���`�Q��;�6�c�?
Ă����_8�_D����v[D��o��Y�����?���������X|�߭�����=Ms#IV˲,:p�l�l�zX��V�[���}�m�-˭��v��R)%�]��T�,�;LgD�6����s ����^ �s��{Y��J_�nO3(gڒ2_�|��>3��ҝ���%��L"���f���n��&��8M�v��n*'��)�H�3�=���(�g%)�n�&S���|��	�A��d2���GIk��S��l���ۻ�M��Ś'By7�k��p��P���x�Jy��Ͻ��q>��i���n�v�:��fsgC3[<K�
���q�6vr	N��ћb���Tn�BT��n_�3�{W�D1�xUѓ�ݳ�B�yb/)�%ƛ��"���R	��24uy��x2�p6�=Nz"���ݐ��$�f8�ce:'7��k����-<���ӇR>S4IT��a�s�L<l�ݳ�ol���1��t���(�=�ۢ�=�~;��y^?	�[u(g��`S.�;h)�FK��cqM"��8(���z�V�[�J=���R ��vDgl����}p����ưR�4�U����С��]��ِ��T<���vM��	(�o����� ����De��M��:����fP�n���X�'���������n���O8�`��$���B��D�<����LK��G�&BWh���"����Ͷ��h��s�(�	V��7���P�y[�E�A�X��Z��s�1jJ�@�6+��CM7�	�0�
�`�<༁�v��蓨D"�8N�I�����CWV(Y����-'�"P���� �A%�6a�%����8B�67�2P�qk��3�j/��VMQV��R�p�$�d! �]�s����%le���[ϜN��J�F�P��EE��o��bM�4.�;�=�MJk�2_��C���NZ'���ɟ�ps�*B�?-��u^���o.4~
��7�j�}�e��� �������cM�{g��z>��R�<�Jy�fU�K���� �'����q"�`l�'<�UT���EH;N�0m�5SqW�h����<K���9Ҽ[�Vk�
��׋Q��nؙ��Z�7�t��#u��ײ�kud=Ob�Ќ���h�c�.�z���9P���5Wgz3��,��̑R1���U���>�q��&���۬g�fky
gk�)�ÊP�I�H�w�s��S��|Z`Az�Ru��L��#f��	"q8 r��i#2�P#��/VB��"�M������ $�`� ~dʊ���qtkj*9hRQM�wE�Y%�z�����n:��8(�ǃG�-�Y˟(��|�tT���je�ſ�K��Q�����:�MπA�VN[��/���C?�S�uc��Gԟݬ�J+��*����*�B���.v#�1}��,?�3�z��<�A���������b�����O�� / rK�Ӄ��Y�q����X@�Ú T�Z�:ؿ(�yt86Ϛk���#���맅w�V�o7�0`*Z��%t�N�뢅XPy�.�k3���De�H�1��j���Qrj���R�@/��w�Dd����BTj� �a)��\Xͅ�hp6K�=�ó�]����w�V:�qBhX<�и�Տ� [�V�ס]q����0_�PQh�ٵ���B� ���.Z _�����E�E���c��Ec�xO3�78x[7H����K63N�5�	?+�[Y�g2]m��+��r��>����of�����@cǨ��!U;F"D��>/3\s籌	~�mt��A�x���G���S|¬dvb%&�aO�7����T�`?�!R���!�g���0�K8���n,a�%L|��0;c	w�SK�|�%L��%�{���}��):�AE�F��'�j�����\"����Mf7����b_���<!ՠ2R���>-E	>�Ҵ6
H���-�E���ݭ�xZ�$#�k�a���V�C]&Ծ�,��@�A9�vl,⸴qhm��D�
C����.#��F�ǜȈ�4�S,0#vR)�M��,�p�*�0n��:t�}G�]�
b�T�14{:�2p���.���!��5ǢNMG6L]n�L�x9�A�� 0b�J��T�0[Pv�E�q��(���F�H�f�\iTj���N/�q崼C(�E�t�c�LG�vذ	��H@W�Y�!��,A���|I��@�U4�����3j �D��ٴt�l���X(����If�E(�P����wu�݀�T3��0h��@��)����w���s1�F�(���	�=�`�vl������dWSd@����hg��+Z��P[���y�r�"~��*X0h��`k�kL2~<'\
^hl�?!��@ۼ�yd��	3р��-�}�)��a[0��P�L�� �[��Y�Ї�a�9��)1S| B��3�]i���B�C��cYk�dC���m�pO(�5�US�~j��Mk���)��9����	���A6�X�V��ɩ� ⵭�,�#C켷�[s��M��������j�hp�=�ሏ�lP��1�����o�sPZ-��v�4��b]�L��9w��e߸��]����� w�<�����b�x�_�<$�ij����º�6�Bۜ�	�^`~l�l�	lQ�r}D��LL�>�te�W���Sb�Hޡjg��0�(x	�BQ�(jQB(T��u��/E�#��pݻ���7Ʀ^ј�ކ,G����7��^�Öa���A����i�e獶��p��.+��-�8�uk��m���<f�"�`����g��ң֚۪&r��$$m��A p�=QA����h�E����U���6*�Ģ�Q;:��F�t7�*HI�W�#E�4��X'���ڿ�D�����Vd
�*ڐ� �'��wIg��I���>s�g�FY��![�y��s ʊ���Q���#PS��[���ژI�뚎f0 G��2�]ut���%�xZG�������<�/n���d8�>g�-��L[��-�������Ҏb7)�c�@~��e��Df�uQ5D��:��C�nZ:-��c'�"ā"��_Ev��^^F�����.A�9�&K8/�xA�lO�����F���$8�	��P:��@<��yKff�{f�jt�\�էF��\"�7�l�C��8��58u���չ&y0��n�1]YDǢlz�c�SF�äc�pfם�ّ����:�ݤ��Z�?`���3�������t.e����x�t&�Y�y���g����ڢ����V6q͢+�`�)��=e]4�Y06���$Jo��!�E�&�:�2��@��w�.���o�C���t���bA8j	��z��:��}�l��������pjc��*��|���M2�{}��]"�������X�����!��e�N,9�LP�n-��IP4p\����?�<���:�<��(���{��8$,\4�C�6u4ٜ!#��Z��-�d����9_R-����J0�����矙�3�kɿIEu����DnF����<J�t���ww9��Y i�f��kz
��]�E�u:�n���=���&=�$�wɟ�8�{��^�u�l����oE9��p��t��AT%����>ɚ����� K�?�L��&��$���g�c#��������ӱVV�!�
��KȚ�Ԍ�]��\3�`s���}n�����E��x����E2��]�}\�a=
p|p�e�dUB/H�Z�f�q��N�|'ݝ�Pƈ�c���<�'4
�F�9���:QG�6տ
Q������އ�����;Y4sl��ƥoo&N���G|��������n�3�`-���6����2�lb��#���_ǩ�e���k�"qPy(بB�k<|��GI�I�����ՊTN]pZ���w��d���+��6��Ɗ�f��c�*�k+�+�7dx��x@��u��Om�̹1��w���w~W��e�^�hI�oI_4H��Mvvǜ &���@�ny(�D������\�=.q_�ǝ��]�O����#�>���y�|�S����d6�����>��o*��@ʊ�b��}��J���7�����^�Me��������.�̗�����Xk�m�	A��7���8.�S�Z��bH�ڇ������?OV������f��Qҧ*���y��`����{����{��	����4Y�WԌUU��3�j�ՕI=�v`RdQ1 `f�ױ�+\�������N���r���?%(.������οq`�= %�F�H��H��B��X��W�|]�7٥���}�����0��,�@o A��UO����7'�9Io�u}G$���'��Z�o�%�E	�I�wC����O���>;��x�3$l�3�8)�Ѝ��O�U��t^�4.gop���NN�7��[S]����u��__B�j4l7 Z��kw�}�6}!��5�y1��;β��t�S�)�e~�B��:�?�������N�̍���ɯ�����1���O1�Y9_��c[�$m�d�CX4x�l��Y�w6ܹи���ψ*w��]
E���&�Bd��,X
(��U:�Z�a�ҋ���oAx�����B��s���<����ǝ�����$6�?<Jz"�&�z���`{��Ͳ��2�.�<��d������o|���?F���e�?啋~<�O�z�D��_~`�=y`�*}y(�W�/8�;�����d�Ѩ��Pǒ�A��>�#������9!��N�(J׸Ǳ�˝VH���'�KBA�	�Lm��|���*��
�,30��/	a2��9K߀6�\��* ��7i���\��=7v�	��ěp�-ƶ߆#��M D�7��\SbY���k:kxҀm_�e�-fѤU :o���A�pߜ���pԘ�)#v�B���(^�GUI�X��dXא8�c?pŹZ�w��\(�!,�3��A���۞ؤi�FE]��7��po�@0��J9�]c��<�]�B��S�ބ*̍���VQ�Ksq_̰]�7U��IcgY���J}��{���j����<��L%����,�	��#�����GI�ߜ��z����G?�����?�v�w]���Oۉn2Oǻ{	H{➘hgR�n.�J�3"M퉙t;����]��vi)���RJ��i���~�׍=��?4��~�_�;��?�
��w��������_��_<��q��ǡI�?����
�~Ǿ���?����OC�ɛk���O򏟅~��������_}�+��.y�}Q�*�
u�z��
��f^`p�y7�x쾛=d���0>�K�Ն4�^U������_���?�p�}?}�\�z|���Z���z���T|wj!^)�w� l�φ����y���kǒ��7�����E�t+$�R��P{ٮ�}%]����o�h����l]�mv��	]�Ճ���Ԯpռ*:���c���T���R�t�{�{�X��JM�zt�m薗�w���n�h��7�m�ڨw����e�(� �P��X�Z�x�P��K�W���^Y�7�n����׽���r�&-_5������e��uBoߜu�^�WK�Ň��t���K]׎E�Y�{�̱~6��2����q��.������h	Ӕ��4���4�J�p�6�mE��.w�ݽ�e��h�Vf����f�T�WK�f��[�{�M��(]��ۇ� 8l$^�W�s�Lj��P&C��`t�T�^&wo�����m�jb��x�������W��)�v�.hG��8��>'��8q>��8N��I����B�@�7�
��J�'$8��V�PA���^�Rp�I&3�;;�v+x�=���?�������p`�|i�fN��ަ��������ܐ'�З6���2�i��Ypn&u��9��z���UU ��*�%�UWO���T˞]�%g��Ւ�U����X�P�则�[��l�ay
6�&nvmٳo󤵷-�-p"��2�a����E����DQ�LC���:1��W#�F�^��x'A᝔M!1nɭj��*��+;y*6ŧ�%�ct�Sl�����l��x��Rxe@$܊
��q ���;�0Y��2��9�`]ʬ��c���\Y�KK]58��Dwy0w�T�MɅ���Z�VSS�A�b�ٜ�7��e*��47�w4��(��.��
MY���6�źqZ��$�f1"�ӈif�����:��S�-6��2�l�/{Ҡ4�4s��ţ�!�ь�ׯ��e�j��s������#�xl�e}6/��*¦t���op��X%���`l�rA�|�Țn2:N�Z[ȷm�C
��&e��B֪��d��w2�s2D4n�
EKi����kJ>�H�U`9�fK��B�OY9ş(y"_��J��̌����G�%�Q>��X�-�N�=���^2]���8gB�lZ�WڕZ�����m'
�,vA��zc����?՛��Lu���)Ӄ�%�0�xB��k,��zcI�{��3�Z5�#q �Y<,wu<��|�(5]����/�%jB�u��{��&*�~�'R��
i�~��5{���x:c��%���%�[�5�(IRL)�B���b,G����X�Q2��G�c>G;S#%��� Yt	<4ᅁa3=������f�
6�Qi��Y�'�=�Vr��l8��[�޴ih>XcI��X���w��tN`,�rE$`���H��5`�bkF��Κ����D��y��ò�$�#�Be�ǲߨ5�LW�a�HY]R9|:ca[ٶ���0J����Fy%�j�B�b,G����Xf����ᦵQۓ����%w�Jn%���m����D��M�{]k4��Y���1m�b�r'�x5��j<1�Ñle�U�3�]T����l'��v���/ ;�$x�<j����}	���9l����o=�s	{b�Qz�(����s���6�lc�6�l�ۼU��������	j����H����=GC=g���D��Xnn`��v�.C}�����ɝ/���?��7�[�a]lk�V���������l��΃G��5X����)�}{���o�|��v��s믹��kإ��``����k���j.iV���9�v1P~|=�[�Zg�Ħ�j�t���\�o���ױ��9��X���!�����{�8�.v ��b����W������y��y�d�x������Cz(8�C��wM��<u��U�V�>G۝Bc�(St��g��HZ=��� ۡLIq\@/�Ϻ�R�gU)��ܢhJ�0�h�Z�ʢvUe��,Ӽ'��07I������"w��H���9��c�e�T��Z�s*R�ʒ#&|�ՐTT5�Ki{}.0P6s�B����,4V��Jc�[��-�n�=��CȆ��"�H�_ܳ�^���"o'x�JNI%��#w�>��C��c:n�ӣ�L��
A�\_���RP�f;R�ѫ�Nŧ�,L�Y��<Pv�c ��g O���1ܟ���p\�lW\9�bSr�r#
Lh!��h�:}�OHJ��)��DIp��Q*��"C����~�o������CzH�t��_�������I��D7eR��(͉ĨD������ȏ�Xu�My��T�|���u�]��9�sܥ�TI/`�E�S��y=�_�l�X�L'lA�+�/b��Oo4��]X78�yWV��Vx��V���?_:��
ߗ
!i�;H�I�HaѺU��%j]8ҳ��ID�Y��G�G�š�<�cT�@���@�&�Y�
,A��nmx���S0�(�!ʨgˉV�fZGY3��� ��}�%	���r��P�	dj��û�#�#8L}v6�b���,BL��P�C�b!�`�B�����TO�|[��������H�Bry:&H���ΑJd���H�n���y3&��f��5`�P�χpU�	�S�8�IDj�e�>�~�%�-�C���8éu�E~:�fa�ݩr&<�
9r��7�8U�>����(��(;���׉ ��l;/�����5As�[)ƣ�>��h�ֿ������h�Fc�S���v\\m�X��V���/
-s|�Vð-p� �p4vր��F�[p�y���x{{h]��̮�_��G����~����񻯿�����__��+��N��k��:8|�|7$�e�#�Yo�Y��~}�]��d��3� ��}���ܛo��_���~x���v��˙�/�����y����q�����x=~�q��ֹy�����+za��_���l��a����7������7v#��E��~��Ͼ��E�؟D���ηw��S;�G�ND�D�ND@4D�Doq?�oq � iD�D�ND�D5��>��S�-�#��)H�'����5z=��Z�p�gnG]5<b��gL]�1��#��_]�>ؠ&��!�*�� �JE�R� 9r��3���=���a]|}����N�Z3��V�f-@�К��9�Ú�{X�{K`��ʜgÝZ;)m�K=C2�Y�K��Z�C�	$H� A�	$H� A�	$H� Ar��?h��   