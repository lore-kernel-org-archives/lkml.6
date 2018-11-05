Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE44ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAAD20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAAD20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dh-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeKESHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:07:14 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:41253 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKESHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:07:13 -0500
Received: from sun05.dh.corp ([188.193.90.127]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPA (Nemesis) id
 1MIxmm-1g4oYm3wMc-00KQvE; Mon, 05 Nov 2018 09:48:31 +0100
Received: from sun05.dh.corp ([188.193.90.127]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPA (Nemesis) id
 1MIxmm-1g4oYm3wMc-00KQvE; Mon, 05 Nov 2018 09:48:31 +0100
Received: from sun1049.dh.corp (unknown [10.64.9.49])
        by sun05.dh.corp (Postfix) with ESMTP id 9A2D51FA3D;
        Mon,  5 Nov 2018 09:48:29 +0100 (CET)
Received: from localhost (10.64.31.3) by sun1049.dh.corp (10.64.9.49) with
 Microsoft SMTP Server id 14.3.408.0; Mon, 5 Nov 2018 09:48:35 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.de>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <C.Emde@osadl.org>
Subject: [PATCH 0/2] Docs/EDID: Fixed and improved EDID documentation
Date:   Mon, 5 Nov 2018 09:48:33 +0100
Message-ID: <1541407715-5417-1-git-send-email-cniedermaier@dh-electronics.de>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.64.31.3]
X-Provags-ID: V03:K1:HXOMch+g9joJ/JAT2212kn+m7rFqYoIIOq9PLp/XUNbCB/LbaTU
 q4GTrLz+3ks1HgBbXT6rg3fpQnmexyuCy1S5iKYwq2XxRaZjmPQc4WScifa2oX1zyD2q5e7
 VMIsmKA9oq59e6XlyL+5GfDAVoOZmSpOaisK3w/U68bMUhCKXCTSnuJjPbWP2rYJ2jIUeMP
 l0y80l3JsaMf07X3tiBQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AU7z7xkCYBY=:7CW3Jr0cm7bZO8bs3Xpo21
 bdvtlDI/qGVyfTfLDj+OQ37Vj4uCurtyKwq2uepLm//7f4OcId+ayq01aq/rLCzga9D5xnvuk
 y2Xp1zsfJd+icQG2cgFqWhJZQni+bs60BtAu88LiMchZI4m0f+SIL6y7Cb+zl1yBI+JPxgvfQ
 lLfZKir3kn44Z1QQT4c43gTWQayko6EJYD+rmIEF3p78viQbq7KvJx0bNNcNmk0S+Ir5MMf3b
 aews6uNoPO8SDf6QlRXpDzDCNBgBiueTrx/oNhBgQnBdHA6NgaOExGpU0/ZROpOEPV6tNWx4r
 XdCdgTnWZnmCqfslidTLMRgdwqYjOJBWzaOQJJ7BKt0yt2xFzzP6EU8EML5oh/ISL7vXoIKiY
 jKc7keqej1DexO9YytJgeHzYH33UI4kEf0xI9mnkQiANtD4dJjTBGbJU25+i4shAuCLciS4HE
 pEsJT2Bapsrfh1CpQzu6qswLY2oEGudiwqWQHX+5l6EcyhdI+PKq+Em9n1lWLzwHEu65qgczC
 wwlTqNI1h/kqXZmbob48rqXRJ9TBK6UbovJSkfphEXOwyrMPrby7qxiqIYeQ3Btt+NTPPmbDA
 gzuRH7QYbUr+QbsFHtHV6KTbXBiXshttSw3p9p+HWcocRw9Jt+eBQueJPYm7ZPcjPxmqA6r2/
 6Z4EPbKMGXpK6mpKph+vfZAKis1CC5b0HDTuQ7IUskIT7oFe9E4qpWDz+PXUPLtjbmO70UJLf
 VxLP/u8bL8bw5ePQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A problem was found when EDID data sets for displays other
than the provided samples were generated. The patch series has
no effect on the provided samples that still match the data
used in drivers/gpu/drm/drm_edid_load.c.
The provided samples use small values for XOFFSET, XPULSE,
YOFFSET and YPULSE, where the error doesn't occur. This fix
corrects the use of that values in case of high values, because
the most significant bits were treated incorrectly.

The previous version made it necessary to first generate an
EDID data set without correct CRC and then to fix the CRC in
a second step. This patch series adds the CRC calculation to the
makefile in such a way that a correct EDID data set is generated
in a single build step.

---

Christoph Niedermaier (2):
  Docs/EDID: Fixed erroneous bits of XOFFSET, XPULSE, YOFFSET and YPULSE
  Docs/EDID: Calculate CRC while building the code

 Documentation/EDID/1024x768.S  |  5 ++---
 Documentation/EDID/1280x1024.S |  5 ++---
 Documentation/EDID/1600x1200.S |  5 ++---
 Documentation/EDID/1680x1050.S |  5 ++---
 Documentation/EDID/1920x1080.S |  5 ++---
 Documentation/EDID/800x600.S   |  5 ++---
 Documentation/EDID/HOWTO.txt   | 13 ++-----------
 Documentation/EDID/Makefile    | 15 +++++++++++++--
 Documentation/EDID/edid.S      | 10 ++++++----
 9 files changed, 33 insertions(+), 35 deletions(-)

-- 
2.1.4

