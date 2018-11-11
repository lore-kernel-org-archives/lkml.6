Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2672C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7828B20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvtX3tO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7828B20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbeKLJkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732930AbeKLISf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:35 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7002B22443;
        Sun, 11 Nov 2018 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975319;
        bh=Fqx8tpDjUTnA2aIhqe06gYAcQYhS19848h5GqHhzgvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvtX3tO2Lcaz+/3PeUxFfEf5bARY6amxOkzq6hdBSaqZ22w8aAo/YZRH2KWF+4otC
         1FK04gieiHLbzOSIA0jY39+DTm/p0pC9hm8YNKavfLq9wqn4igO0EyqJqOcj2y2GQ9
         WvcdMDNzgkBtfTOQNiw1SVYtFvYDweN+bgFYHQbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 313/361] media: media colorspaces*.rst: rename AdobeRGB to opRGB
Date:   Sun, 11 Nov 2018 14:21:00 -0800
Message-Id: <20181111221658.444009595@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hansverk@cisco.com>

commit a58c37978cf02f6d35d05ee4e9288cb8455f1401 upstream.

Drop all Adobe references and use the official opRGB standard
instead.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: stable@vger.kernel.org
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/media/uapi/v4l/biblio.rst              |   10 ----------
 Documentation/media/uapi/v4l/colorspaces-defs.rst    |    8 ++++----
 Documentation/media/uapi/v4l/colorspaces-details.rst |   13 ++++++-------
 3 files changed, 10 insertions(+), 21 deletions(-)

--- a/Documentation/media/uapi/v4l/biblio.rst
+++ b/Documentation/media/uapi/v4l/biblio.rst
@@ -226,16 +226,6 @@ xvYCC
 
 :author:    International Electrotechnical Commission (http://www.iec.ch)
 
-.. _adobergb:
-
-AdobeRGB
-========
-
-
-:title:     Adobe© RGB (1998) Color Image Encoding Version 2005-05
-
-:author:    Adobe Systems Incorporated (http://www.adobe.com)
-
 .. _oprgb:
 
 opRGB
--- a/Documentation/media/uapi/v4l/colorspaces-defs.rst
+++ b/Documentation/media/uapi/v4l/colorspaces-defs.rst
@@ -51,8 +51,8 @@ whole range, 0-255, dividing the angular
       - See :ref:`col-rec709`.
     * - ``V4L2_COLORSPACE_SRGB``
       - See :ref:`col-srgb`.
-    * - ``V4L2_COLORSPACE_ADOBERGB``
-      - See :ref:`col-adobergb`.
+    * - ``V4L2_COLORSPACE_OPRGB``
+      - See :ref:`col-oprgb`.
     * - ``V4L2_COLORSPACE_BT2020``
       - See :ref:`col-bt2020`.
     * - ``V4L2_COLORSPACE_DCI_P3``
@@ -90,8 +90,8 @@ whole range, 0-255, dividing the angular
       - Use the Rec. 709 transfer function.
     * - ``V4L2_XFER_FUNC_SRGB``
       - Use the sRGB transfer function.
-    * - ``V4L2_XFER_FUNC_ADOBERGB``
-      - Use the AdobeRGB transfer function.
+    * - ``V4L2_XFER_FUNC_OPRGB``
+      - Use the opRGB transfer function.
     * - ``V4L2_XFER_FUNC_SMPTE240M``
       - Use the SMPTE 240M transfer function.
     * - ``V4L2_XFER_FUNC_NONE``
--- a/Documentation/media/uapi/v4l/colorspaces-details.rst
+++ b/Documentation/media/uapi/v4l/colorspaces-details.rst
@@ -290,15 +290,14 @@ Y' is clamped to the range [0…1] and C
 170M/BT.601. The Y'CbCr quantization is limited range.
 
 
-.. _col-adobergb:
+.. _col-oprgb:
 
-Colorspace Adobe RGB (V4L2_COLORSPACE_ADOBERGB)
+Colorspace opRGB (V4L2_COLORSPACE_OPRGB)
 ===============================================
 
-The :ref:`adobergb` standard defines the colorspace used by computer
-graphics that use the AdobeRGB colorspace. This is also known as the
-:ref:`oprgb` standard. The default transfer function is
-``V4L2_XFER_FUNC_ADOBERGB``. The default Y'CbCr encoding is
+The :ref:`oprgb` standard defines the colorspace used by computer
+graphics that use the opRGB colorspace. The default transfer function is
+``V4L2_XFER_FUNC_OPRGB``. The default Y'CbCr encoding is
 ``V4L2_YCBCR_ENC_601``. The default Y'CbCr quantization is limited
 range.
 
@@ -312,7 +311,7 @@ The chromaticities of the primary colors
 
 .. tabularcolumns:: |p{4.4cm}|p{4.4cm}|p{8.7cm}|
 
-.. flat-table:: Adobe RGB Chromaticities
+.. flat-table:: opRGB Chromaticities
     :header-rows:  1
     :stub-columns: 0
     :widths:       1 1 2


