Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeCFBFc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 20:05:32 -0500
Received: from ozlabs.org ([103.22.144.67]:34673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752460AbeCFBFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 20:05:30 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 6 Mar 2018 12:05:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robherring2@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the devicetree tree
Message-ID: <20180306120511.1b480c32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TI3sDtET/RW45ETjEtZ+zuP"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TI3sDtET/RW45ETjEtZ+zuP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

After merging the devicetree tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb: Warning (chosen_node_stdo=
ut_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb: Warning (chosen_node_stdout_pat=
h): /chosen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning (chosen_node_std=
out_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb: Warning (chosen_node_stdo=
ut_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb: Warning (chosen_node_stdo=
ut_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb: Warning (chosen_node_std=
out_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/imx6ul-isiot-nand.dtb: Warning (sound_dai_property): /sou=
nd/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /so=
c/aips-bus@2100000/i2c@21a0000/codec@a or bad phandle (referred from sound-=
dai[0])
arch/arm/boot/dts/imx6ul-geam.dtb: Warning (sound_dai_property): /sound/sim=
ple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips=
-bus@2100000/i2c@21a0000/codec@a or bad phandle (referred from sound-dai[0])
arch/arm/boot/dts/imx6ul-isiot-emmc.dtb: Warning (sound_dai_property): /sou=
nd/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /so=
c/aips-bus@2100000/i2c@21a0000/codec@a or bad phandle (referred from sound-=
dai[0])
arch/arm/boot/dts/vf610m4-colibri.dtb: Warning (chosen_node_stdout_path): /=
chosen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/rk3288-tinker.dtb: Warning (sound_dai_property): /sound/s=
imple-audio-card,codec: Missing property '#sound-dai-cells' in node /hdmi@f=
f980000 or bad phandle (referred from sound-dai[0])
arch/arm/boot/dts/stih410-b2120.dtb: Warning (chosen_node_stdout_path): /ch=
osen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/stih410-b2120.dtb: Warning (sound_dai_property): /soc/sou=
nd/simple-audio-card,dai-link@0/codec: Missing property '#sound-dai-cells' =
in node /soc/sti-display-subsystem/sti-hdmi@8d04000 or bad phandle (referre=
d from sound-dai[0])
arch/arm/boot/dts/stih407-b2120.dtb: Warning (chosen_node_stdout_path): /ch=
osen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/stih407-b2120.dtb: Warning (sound_dai_property): /soc/sou=
nd/simple-audio-card,dai-link@0/codec: Missing property '#sound-dai-cells' =
in node /soc/sti-display-subsystem/sti-hdmi@8d04000 or bad phandle (referre=
d from sound-dai[0])
arch/arm/boot/dts/stih410-b2260.dtb: Warning (chosen_node_stdout_path): /ch=
osen:linux,stdout-path: Use 'stdout-path' instead
arch/arm/boot/dts/stih410-b2260.dtb: Warning (sound_dai_property): /soc/sou=
nd/simple-audio-card,dai-link@0/codec: Missing property '#sound-dai-cells' =
in node /soc/sti-display-subsystem/sti-hdmi@8d04000 or bad phandle (referre=
d from sound-dai[0])
arch/arm/boot/dts/stih418-b2199.dtb: Warning (chosen_node_stdout_path): /ch=
osen:linux,stdout-path: Use 'stdout-path' instead

Presumably introduced by commit

  c0e8e5234671 ("scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65=
c987")

or

  f26e93812a4f ("scripts: re-enable some now fixed dtc warnings")

--=20
Cheers,
Stephen Rothwell

--Sig_/TI3sDtET/RW45ETjEtZ+zuP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqd6UcACgkQAVBC80lX
0GxgOQf/dUt0YEIxDVuwPgnhyFTNEMCoX/vuRlClWhL60LeDppwNwOgwExuE1VxJ
5wnoiwerAuzlUeahZ/lhbhAA4Ccp8hxseTam9hg8SR6nho/CIw5KsLiDJQOrnl86
BQU0Ev2kLRrvV63j70zg2plnhD5X6oS5Fl5huGeolkqfJFExJ1u12V4Y2pkWwnom
6cn7Yi6smfg75FrpiWdFPwJw2dVkxorme3msj80twGsag9NhMM9MeTZqKCL4vKYD
ZqR2jKl6I3PYMP/68SV49FE2M/ZH6GRq2a8SGTh8DMIbt5HFjJnDPLpZ3KjCgt75
XBXCwpgeemNU9swX42qtiOlPOtmKdw==
=dIj3
-----END PGP SIGNATURE-----

--Sig_/TI3sDtET/RW45ETjEtZ+zuP--
