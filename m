Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B176C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8E620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8E620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeLCLsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:48:23 -0500
Received: from shell.v3.sk ([90.176.6.54]:37867 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeLCLsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:48:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9A4F3C80DB;
        Mon,  3 Dec 2018 12:47:38 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RsTWr7agvf6T; Mon,  3 Dec 2018 12:47:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 58ECEC8121;
        Mon,  3 Dec 2018 12:47:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oY5vHsz-0GEx; Mon,  3 Dec 2018 12:47:35 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B2020C80DB;
        Mon,  3 Dec 2018 12:47:35 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] ASoC: dt-bindings: use a generic node name for rt5631
Date:   Mon,  3 Dec 2018 12:47:28 +0100
Message-Id: <20181203114728.636936-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example should follow the practice or using a generic node name
instead of the precise programming model, as recommended by the DTSpec.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/sound/rt5631.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5631.txt b/Documen=
tation/devicetree/bindings/sound/rt5631.txt
index 92b986ca337b..56bc85232c49 100644
--- a/Documentation/devicetree/bindings/sound/rt5631.txt
+++ b/Documentation/devicetree/bindings/sound/rt5631.txt
@@ -35,14 +35,14 @@ Pins on the device (for linking into audio routes):
=20
 Example:
=20
-alc5631: alc5631@1a {
+alc5631: audio-codec@1a {
 	compatible =3D "realtek,alc5631";
 	reg =3D <0x1a>;
 };
=20
 or
=20
-rt5631: rt5631@1a {
+rt5631: audio-codec@1a {
 	compatible =3D "realtek,rt5631";
 	reg =3D <0x1a>;
 };
--=20
2.19.1

