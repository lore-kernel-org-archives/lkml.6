Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5FDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3BD20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3BD20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbeGXMXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:23:44 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33167 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388298AbeGXMXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:23:44 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MHQzX-1flY613eyZ-00E3YD; Tue, 24 Jul 2018 13:17:27 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] lib/fonts: convert comments to utf-8
Date:   Tue, 24 Jul 2018 13:13:27 +0200
Message-Id: <20180724111600.4158975-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724111600.4158975-1-arnd@arndb.de>
References: <20180724111600.4158975-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=Binary
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SAl+ls4lwmQfUiY2Wzh/NUMmNjJSwGBS/uBTBlDjifh1R8OI74j
 ch9WrAEHKYlfOccmKsSJrRS8eKlTz3d6QXztPMGFVJ96U6RdhUm4aGf7qEaEOnXpqU5hHmF
 57NuDx5peFiXEllNdPWa8Jhlm+NBy4OVGfwWrqY1feRxIFMQLktO7EqYIngyz+/vQBPLZqs
 KDwcMCUJeQF3aTRdPJRAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oogoDN5O4nU=:nXdoQqg9CV46XOuVNSAOAF
 WHQjP931dW2jFrADZxYMglayDUFKUyYcWdPiE9Iu2XqNhD5s8efVfqdwn8PnIABPUFqkgXalh
 gcr9wHJSUDnjC2cJD6+jSHzLtGHopuIKDTcLJDjJ8LbMGcyMWIQHIlvjB4d77pH6FzAKlHSa+
 9vmTVYUZPkl8rXj6z9T8OucztMfEvxIe74GRN+iKeaGOtAhmGhOjE9am1rsS71+wO51zmtWv4
 QeM9qJkVNXis92C4MM9NhuMuba+sv/oGMF5UtGf43UCCBQARJI0MSPXviYOOzX0OF7TxGn+up
 LlbHwKXJ5B2zbdRBKqoD4v+5t/8b4wOWvifgKbwkcTTNOeEXllKfITfW5Pl/4mxmNiasDn/TH
 Jraa5wLkDqFVBbKyoQAMEOsEB5CfEj/y/ATt3VlIkrGGKfE80Gx7f68xSF9KV2+AAFReeVuQA
 QWaJb019iFTXI6x2TsSEUSszJiw0oHpgvNraPhDYOw1ujmOURYZqaJDWlaocQXvVH1dsoXO6+
 RkYP1Bk42EwIcWNP4Nj7+TxuYNXhqEJP0ZjcjlPGe7QC/oUYUOd5WX9lzl0jZrzKfmKFqy7sF
 eUDPi7JWaJdi0hk8csbZ338EfpxTfzD9DUrEBRl1NH6KNQq3cZqZaYdRpJKLhDPGBbhYlvtOF
 iXQH5Sk72jhK+tX15+gkOHsyGKpv2d1X2/QBvF+ubPja7/tghmI3ksfLCTyzDPqYNQO4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The font files contain bit masks for characters in the cp437 character
set, and comments showing what character this is supposed to be.

This only makes sense when the terminal used to view the files is
set to the same codepage, but all other files in the kernel now use
utf-8 encoding.

This changes those comments to utf-8 as well, for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/fonts/font_7x14.c      | 256 ++++++++++++++++++-------------------
 lib/fonts/font_8x16.c      | 256 ++++++++++++++++++-------------------
 lib/fonts/font_8x8.c       | 256 ++++++++++++++++++-------------------
 lib/fonts/font_pearl_8x8.c | 256 ++++++++++++++++++-------------------
 4 files changed, 512 insertions(+), 512 deletions(-)

diff --git a/lib/fonts/font_7x14.c b/lib/fonts/font_7x14.c
index 9ae5b62c8a0d..89752d0b23e8 100644
--- a/lib/fonts/font_7x14.c
+++ b/lib/fonts/font_7x14.c
@@ -2058,7 +2058,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 128 0x80 'Ä' */
+	/* 128 0x80 '√á' */
 	0x00, /* 0000000 */
 	0x38, /* 0011100 */
 	0x6c, /* 0110110 */
@@ -2074,7 +2074,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x70, /* 0111000 */
 	0x00, /* 0000000 */
 
-	/* 129 0x81 'Å' */
+	/* 129 0x81 '√º' */
 	0x00, /* 0000000 */
 	0xcc, /* 1100110 */
 	0x00, /* 0000000 */
@@ -2090,7 +2090,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 130 0x82 'Ç' */
+	/* 130 0x82 '√©' */
 	0x0c, /* 0000110 */
 	0x18, /* 0001100 */
 	0x30, /* 0011000 */
@@ -2106,7 +2106,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 131 0x83 'É' */
+	/* 131 0x83 '√¢' */
 	0x10, /* 0001000 */
 	0x38, /* 0011100 */
 	0x6c, /* 0110110 */
@@ -2122,7 +2122,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 132 0x84 'Ñ' */
+	/* 132 0x84 '√§' */
 	0x00, /* 0000000 */
 	0xcc, /* 1100110 */
 	0x00, /* 0000000 */
@@ -2138,7 +2138,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 133 0x85 'Ö' */
+	/* 133 0x85 '√†' */
 	0x60, /* 0110000 */
 	0x30, /* 0011000 */
 	0x18, /* 0001100 */
@@ -2154,7 +2154,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 134 0x86 'Ü' */
+	/* 134 0x86 '√•' */
 	0x38, /* 0011100 */
 	0x6c, /* 0110110 */
 	0x38, /* 0011100 */
@@ -2170,7 +2170,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 135 0x87 'á' */
+	/* 135 0x87 '√ß' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -2186,7 +2186,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0xe0, /* 1110000 */
 
-	/* 136 0x88 'à' */
+	/* 136 0x88 '√™' */
 	0x10, /* 0001000 */
 	0x38, /* 0011100 */
 	0x6c, /* 0110110 */
@@ -2202,7 +2202,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 137 0x89 'â' */
+	/* 137 0x89 '√´' */
 	0x00, /* 0000000 */
 	0xcc, /* 1100110 */
 	0x00, /* 0000000 */
@@ -2218,7 +2218,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 138 0x8a 'ä' */
+	/* 138 0x8a '√®' */
 	0xc0, /* 1100000 */
 	0x60, /* 0110000 */
 	0x30, /* 0011000 */
@@ -2234,7 +2234,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 139 0x8b 'ã' */
+	/* 139 0x8b '√Ø' */
 	0x00, /* 0000000 */
 	0x6c, /* 0110110 */
 	0x00, /* 0000000 */
@@ -2250,7 +2250,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 140 0x8c 'å' */
+	/* 140 0x8c '√Æ' */
 	0x30, /* 0011000 */
 	0x78, /* 0111100 */
 	0xcc, /* 1100110 */
@@ -2266,7 +2266,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 141 0x8d 'ç' */
+	/* 141 0x8d '√¨' */
 	0xc0, /* 1100000 */
 	0x60, /* 0110000 */
 	0x30, /* 0011000 */
@@ -2282,7 +2282,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 142 0x8e 'é' */
+	/* 142 0x8e '√Ñ' */
 	0x00, /* 0000000 */
 	0xcc, /* 1100110 */
 	0x00, /* 0000000 */
@@ -2298,7 +2298,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 143 0x8f 'è' */
+	/* 143 0x8f '√Ö' */
 	0x30, /* 0011000 */
 	0x48, /* 0100100 */
 	0x48, /* 0100100 */
@@ -2314,7 +2314,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 144 0x90 'ê' */
+	/* 144 0x90 '√â' */
 	0x18, /* 0001100 */
 	0x30, /* 0011000 */
 	0xfc, /* 1111110 */
@@ -2330,7 +2330,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 145 0x91 'ë' */
+	/* 145 0x91 '√¶' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -2346,7 +2346,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 146 0x92 'í' */
+	/* 146 0x92 '√Ü' */
 	0x00, /* 0000000 */
 	0x3e, /* 0011111 */
 	0x6c, /* 0110110 */
@@ -2362,7 +2362,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 147 0x93 'ì' */
+	/* 147 0x93 '√¥' */
 	0x10, /* 0001000 */
 	0x38, /* 0011100 */
 	0x6c, /* 0110110 */
@@ -2378,7 +2378,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 148 0x94 'î' */
+	/* 148 0x94 '√∂' */
 	0x00, /* 0000000 */
 	0xcc, /* 1100110 */
 	0x00, /* 0000000 */
@@ -2394,7 +2394,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 149 0x95 'ï' */
+	/* 149 0x95 '√≤' */
 	0xc0, /* 1100000 */
 	0x60, /* 0110000 */
 	0x30, /* 0011000 */
@@ -2410,7 +2410,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 150 0x96 'ñ' */
+	/* 150 0x96 '√ª' */
 	0x30, /* 0011000 */
 	0x78, /* 0111100 */
 	0xcc, /* 1100110 */
@@ -2426,7 +2426,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 151 0x97 'ó' */
+	/* 151 0x97 '√π' */
 	0x60, /* 0110000 */
 	0x30, /* 0011000 */
 	0x18, /* 0001100 */
@@ -2442,7 +2442,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 152 0x98 'ò' */
+	/* 152 0x98 '√ø' */
 	0x00, /* 0000000 */
 	0xcc, /* 1100110 */
 	0x00, /* 0000000 */
@@ -2458,7 +2458,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x18, /* 0001100 */
 	0x70, /* 0111000 */
 
-	/* 153 0x99 'ô' */
+	/* 153 0x99 '√ñ' */
 	0xcc, /* 1100110 */
 	0x00, /* 0000000 */
 	0x78, /* 0111100 */
@@ -2474,7 +2474,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 154 0x9a 'ö' */
+	/* 154 0x9a '√ú' */
 	0xcc, /* 1100110 */
 	0x00, /* 0000000 */
 	0xcc, /* 1100110 */
@@ -2490,7 +2490,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 155 0x9b 'õ' */
+	/* 155 0x9b '¬¢' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x7c, /* 0111110 */
@@ -2506,7 +2506,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 156 0x9c 'ú' */
+	/* 156 0x9c '¬£' */
 	0x38, /* 0011100 */
 	0x6c, /* 0110110 */
 	0x64, /* 0110010 */
@@ -2522,7 +2522,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 157 0x9d 'ù' */
+	/* 157 0x9d '¬•' */
 	0x00, /* 0000000 */
 	0xcc, /* 1100110 */
 	0xcc, /* 1100110 */
@@ -2538,7 +2538,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 158 0x9e 'û' */
+	/* 158 0x9e '‚Çß' */
 	0xf8, /* 1111100 */
 	0xcc, /* 1100110 */
 	0xcc, /* 1100110 */
@@ -2554,7 +2554,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 159 0x9f 'ü' */
+	/* 159 0x9f '∆í' */
 	0x1c, /* 0001110 */
 	0x36, /* 0011011 */
 	0x30, /* 0011000 */
@@ -2570,7 +2570,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 160 0xa0 '†' */
+	/* 160 0xa0 '√°' */
 	0x18, /* 0001100 */
 	0x30, /* 0011000 */
 	0x60, /* 0110000 */
@@ -2586,7 +2586,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 161 0xa1 '°' */
+	/* 161 0xa1 '√≠' */
 	0x18, /* 0001100 */
 	0x30, /* 0011000 */
 	0x60, /* 0110000 */
@@ -2602,7 +2602,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 162 0xa2 '¢' */
+	/* 162 0xa2 '√≥' */
 	0x18, /* 0001100 */
 	0x30, /* 0011000 */
 	0x60, /* 0110000 */
@@ -2618,7 +2618,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 163 0xa3 '£' */
+	/* 163 0xa3 '√∫' */
 	0x18, /* 0001100 */
 	0x30, /* 0011000 */
 	0x60, /* 0110000 */
@@ -2634,7 +2634,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 164 0xa4 '§' */
+	/* 164 0xa4 '√±' */
 	0x00, /* 0000000 */
 	0x76, /* 0111011 */
 	0xdc, /* 1101110 */
@@ -2650,7 +2650,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 165 0xa5 '•' */
+	/* 165 0xa5 '√ë' */
 	0x76, /* 0111011 */
 	0xdc, /* 1101110 */
 	0x00, /* 0000000 */
@@ -2666,7 +2666,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 166 0xa6 '¶' */
+	/* 166 0xa6 '¬™' */
 	0x00, /* 0000000 */
 	0x78, /* 0111100 */
 	0xd8, /* 1101100 */
@@ -2682,7 +2682,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 167 0xa7 'ß' */
+	/* 167 0xa7 '¬∫' */
 	0x00, /* 0000000 */
 	0x70, /* 0111000 */
 	0xd8, /* 1101100 */
@@ -2698,7 +2698,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 168 0xa8 '®' */
+	/* 168 0xa8 '¬ø' */
 	0x00, /* 0000000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -2714,7 +2714,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 169 0xa9 '©' */
+	/* 169 0xa9 '‚åê' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -2730,7 +2730,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 170 0xaa '™' */
+	/* 170 0xaa '¬¨' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -2746,7 +2746,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 171 0xab '´' */
+	/* 171 0xab '¬Ω' */
 	0x60, /* 0110000 */
 	0xe0, /* 1110000 */
 	0x62, /* 0110001 */
@@ -2762,7 +2762,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x7c, /* 0111110 */
 
-	/* 172 0xac '¨' */
+	/* 172 0xac '¬º' */
 	0x60, /* 0110000 */
 	0xe0, /* 1110000 */
 	0x62, /* 0110001 */
@@ -2778,7 +2778,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x0c, /* 0000110 */
 	0x00, /* 0000000 */
 
-	/* 173 0xad '≠' */
+	/* 173 0xad '¬°' */
 	0x00, /* 0000000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -2794,7 +2794,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 174 0xae 'Æ' */
+	/* 174 0xae '¬´' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -2810,7 +2810,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 175 0xaf 'Ø' */
+	/* 175 0xaf '¬ª' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -2826,7 +2826,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 176 0xb0 '∞' */
+	/* 176 0xb0 '‚ñë' */
 	0x88, /* 1000100 */
 	0x22, /* 0010001 */
 	0x88, /* 1000100 */
@@ -2842,7 +2842,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x88, /* 1000100 */
 	0x22, /* 0010001 */
 
-	/* 177 0xb1 '±' */
+	/* 177 0xb1 '‚ñí' */
 	0x54, /* 0101010 */
 	0xaa, /* 1010101 */
 	0x54, /* 0101010 */
@@ -2858,7 +2858,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x54, /* 0101010 */
 	0xaa, /* 1010101 */
 
-	/* 178 0xb2 '≤' */
+	/* 178 0xb2 '‚ñì' */
 	0xee, /* 1110111 */
 	0xba, /* 1011101 */
 	0xee, /* 1110111 */
@@ -2874,7 +2874,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0xee, /* 1110111 */
 	0xba, /* 1011101 */
 
-	/* 179 0xb3 '≥' */
+	/* 179 0xb3 '‚îÇ' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -2890,7 +2890,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 180 0xb4 '¥' */
+	/* 180 0xb4 '‚î§' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -2906,7 +2906,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 181 0xb5 'µ' */
+	/* 181 0xb5 '‚ï°' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -2922,7 +2922,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 182 0xb6 '∂' */
+	/* 182 0xb6 '‚ï¢' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -2938,7 +2938,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 183 0xb7 '∑' */
+	/* 183 0xb7 '‚ïñ' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -2954,7 +2954,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 184 0xb8 '∏' */
+	/* 184 0xb8 '‚ïï' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -2970,7 +2970,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 185 0xb9 'π' */
+	/* 185 0xb9 '‚ï£' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -2986,7 +2986,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 186 0xba '∫' */
+	/* 186 0xba '‚ïë' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3002,7 +3002,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 187 0xbb 'ª' */
+	/* 187 0xbb '‚ïó' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3018,7 +3018,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 188 0xbc 'º' */
+	/* 188 0xbc '‚ïù' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3034,7 +3034,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 189 0xbd 'Ω' */
+	/* 189 0xbd '‚ïú' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3050,7 +3050,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 190 0xbe 'æ' */
+	/* 190 0xbe '‚ïõ' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3066,7 +3066,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 191 0xbf 'ø' */
+	/* 191 0xbf '‚îê' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3082,7 +3082,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 192 0xc0 '¿' */
+	/* 192 0xc0 '‚îî' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3098,7 +3098,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 193 0xc1 '¡' */
+	/* 193 0xc1 '‚î¥' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3114,7 +3114,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 194 0xc2 '¬' */
+	/* 194 0xc2 '‚î¨' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3130,7 +3130,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 195 0xc3 '√' */
+	/* 195 0xc3 '‚îú' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3146,7 +3146,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 196 0xc4 'ƒ' */
+	/* 196 0xc4 '‚îÄ' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3162,7 +3162,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 197 0xc5 '≈' */
+	/* 197 0xc5 '‚îº' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3178,7 +3178,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 198 0xc6 '∆' */
+	/* 198 0xc6 '‚ïû' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3194,7 +3194,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 199 0xc7 '«' */
+	/* 199 0xc7 '‚ïü' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3210,7 +3210,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 200 0xc8 '»' */
+	/* 200 0xc8 '‚ïö' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3226,7 +3226,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 201 0xc9 '…' */
+	/* 201 0xc9 '‚ïî' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3242,7 +3242,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 202 0xca ' ' */
+	/* 202 0xca '‚ï©' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3258,7 +3258,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 203 0xcb 'À' */
+	/* 203 0xcb '‚ï¶' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3274,7 +3274,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 204 0xcc 'Ã' */
+	/* 204 0xcc '‚ï†' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3290,7 +3290,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 205 0xcd 'Õ' */
+	/* 205 0xcd '‚ïê' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3306,7 +3306,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 206 0xce 'Œ' */
+	/* 206 0xce '‚ï¨' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3322,7 +3322,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 207 0xcf 'œ' */
+	/* 207 0xcf '‚ïß' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3338,7 +3338,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 208 0xd0 '–' */
+	/* 208 0xd0 '‚ï®' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3354,7 +3354,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 209 0xd1 '—' */
+	/* 209 0xd1 '‚ï§' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3370,7 +3370,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 210 0xd2 '“' */
+	/* 210 0xd2 '‚ï•' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3386,7 +3386,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 211 0xd3 '”' */
+	/* 211 0xd3 '‚ïô' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3402,7 +3402,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 212 0xd4 '‘' */
+	/* 212 0xd4 '‚ïò' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3418,7 +3418,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 213 0xd5 '’' */
+	/* 213 0xd5 '‚ïí' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3434,7 +3434,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 214 0xd6 '÷' */
+	/* 214 0xd6 '‚ïì' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3450,7 +3450,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 215 0xd7 '◊' */
+	/* 215 0xd7 '‚ï´' */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3466,7 +3466,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
 
-	/* 216 0xd8 'ÿ' */
+	/* 216 0xd8 '‚ï™' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3482,7 +3482,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 217 0xd9 'Ÿ' */
+	/* 217 0xd9 '‚îò' */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
@@ -3498,7 +3498,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 218 0xda '⁄' */
+	/* 218 0xda '‚îå' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3514,7 +3514,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 219 0xdb '€' */
+	/* 219 0xdb '‚ñà' */
 	0xfe, /* 1111111 */
 	0xfe, /* 1111111 */
 	0xfe, /* 1111111 */
@@ -3530,7 +3530,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0xfe, /* 1111111 */
 	0xfe, /* 1111111 */
 
-	/* 220 0xdc '‹' */
+	/* 220 0xdc '‚ñÑ' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3546,7 +3546,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0xfe, /* 1111111 */
 	0xfe, /* 1111111 */
 
-	/* 221 0xdd '›' */
+	/* 221 0xdd '‚ñå' */
 	0xe0, /* 1110000 */
 	0xe0, /* 1110000 */
 	0xe0, /* 1110000 */
@@ -3562,7 +3562,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0xe0, /* 1110000 */
 	0xe0, /* 1110000 */
 
-	/* 222 0xde 'ﬁ' */
+	/* 222 0xde '‚ñê' */
 	0x1e, /* 0001111 */
 	0x1e, /* 0001111 */
 	0x1e, /* 0001111 */
@@ -3578,7 +3578,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x1e, /* 0001111 */
 	0x1e, /* 0001111 */
 
-	/* 223 0xdf 'ﬂ' */
+	/* 223 0xdf '‚ñÄ' */
 	0xfe, /* 1111111 */
 	0xfe, /* 1111111 */
 	0xfe, /* 1111111 */
@@ -3594,7 +3594,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 224 0xe0 '‡' */
+	/* 224 0xe0 'Œ±' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3610,7 +3610,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 225 0xe1 '·' */
+	/* 225 0xe1 '√ü' */
 	0x00, /* 0000000 */
 	0x78, /* 0111100 */
 	0xcc, /* 1100110 */
@@ -3626,7 +3626,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 226 0xe2 '‚' */
+	/* 226 0xe2 'Œì' */
 	0x00, /* 0000000 */
 	0xfc, /* 1111110 */
 	0xcc, /* 1100110 */
@@ -3642,7 +3642,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 227 0xe3 '„' */
+	/* 227 0xe3 'œÄ' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0xfe, /* 1111111 */
@@ -3658,7 +3658,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 228 0xe4 '‰' */
+	/* 228 0xe4 'Œ£' */
 	0x00, /* 0000000 */
 	0xfc, /* 1111110 */
 	0xcc, /* 1100110 */
@@ -3674,7 +3674,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 229 0xe5 'Â' */
+	/* 229 0xe5 'œÉ' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3690,7 +3690,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 230 0xe6 'Ê' */
+	/* 230 0xe6 '¬µ' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3706,7 +3706,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0xc0, /* 1100000 */
 	0x80, /* 1000000 */
 
-	/* 231 0xe7 'Á' */
+	/* 231 0xe7 'œÑ' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3722,7 +3722,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 232 0xe8 'Ë' */
+	/* 232 0xe8 'Œ¶' */
 	0x00, /* 0000000 */
 	0xfc, /* 1111110 */
 	0x30, /* 0011000 */
@@ -3738,7 +3738,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 233 0xe9 'È' */
+	/* 233 0xe9 'Œò' */
 	0x00, /* 0000000 */
 	0x38, /* 0011100 */
 	0x6c, /* 0110110 */
@@ -3754,7 +3754,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 234 0xea 'Í' */
+	/* 234 0xea 'Œ©' */
 	0x00, /* 0000000 */
 	0x38, /* 0011100 */
 	0x6c, /* 0110110 */
@@ -3770,7 +3770,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 235 0xeb 'Î' */
+	/* 235 0xeb 'Œ¥' */
 	0x00, /* 0000000 */
 	0x3c, /* 0011110 */
 	0x60, /* 0110000 */
@@ -3786,7 +3786,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 236 0xec 'Ï' */
+	/* 236 0xec '‚àû' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3802,7 +3802,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 237 0xed 'Ì' */
+	/* 237 0xed 'œÜ' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x06, /* 0000011 */
@@ -3818,7 +3818,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 238 0xee 'Ó' */
+	/* 238 0xee 'Œµ' */
 	0x00, /* 0000000 */
 	0x1c, /* 0001110 */
 	0x30, /* 0011000 */
@@ -3834,7 +3834,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 239 0xef 'Ô' */
+	/* 239 0xef '‚à©' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x78, /* 0111100 */
@@ -3850,7 +3850,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 240 0xf0 '' */
+	/* 240 0xf0 '‚â°' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3866,7 +3866,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 241 0xf1 'Ò' */
+	/* 241 0xf1 '¬±' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3882,7 +3882,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 242 0xf2 'Ú' */
+	/* 242 0xf2 '‚â•' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x60, /* 0110000 */
@@ -3898,7 +3898,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 243 0xf3 'Û' */
+	/* 243 0xf3 '‚â§' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x18, /* 0001100 */
@@ -3914,7 +3914,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 244 0xf4 'Ù' */
+	/* 244 0xf4 '‚å†' */
 	0x00, /* 0000000 */
 	0x1c, /* 0001110 */
 	0x36, /* 0011011 */
@@ -3930,7 +3930,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x30, /* 0011000 */
 	0x30, /* 0011000 */
 
-	/* 245 0xf5 'ı' */
+	/* 245 0xf5 '‚å°' */
 	0x18, /* 0001100 */
 	0x18, /* 0001100 */
 	0x18, /* 0001100 */
@@ -3946,7 +3946,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 246 0xf6 'ˆ' */
+	/* 246 0xf6 '√∑' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3962,7 +3962,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 247 0xf7 '˜' */
+	/* 247 0xf7 '‚âà' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -3978,7 +3978,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 248 0xf8 '¯' */
+	/* 248 0xf8 '¬∞' */
 	0x38, /* 0011100 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -3994,7 +3994,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 249 0xf9 '˘' */
+	/* 249 0xf9 '¬∑' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -4010,7 +4010,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 250 0xfa '˙' */
+	/* 250 0xfa '‚Ä¢' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -4026,7 +4026,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 251 0xfb '˚' */
+	/* 251 0xfb '‚àö' */
 	0x1e, /* 0001111 */
 	0x18, /* 0001100 */
 	0x18, /* 0001100 */
@@ -4042,7 +4042,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 252 0xfc '¸' */
+	/* 252 0xfc '‚Åø' */
 	0xd8, /* 1101100 */
 	0x6c, /* 0110110 */
 	0x6c, /* 0110110 */
@@ -4058,7 +4058,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 253 0xfd '˝' */
+	/* 253 0xfd '¬≤' */
 	0x78, /* 0111100 */
 	0xcc, /* 1100110 */
 	0x18, /* 0001100 */
@@ -4074,7 +4074,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 254 0xfe '˛' */
+	/* 254 0xfe '‚ñ†' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
@@ -4090,7 +4090,7 @@ static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 
-	/* 255 0xff 'ˇ' */
+	/* 255 0xff '¬†' */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
 	0x00, /* 0000000 */
diff --git a/lib/fonts/font_8x16.c b/lib/fonts/font_8x16.c
index 34292cdfaa23..b7ab1f5fbdb8 100644
--- a/lib/fonts/font_8x16.c
+++ b/lib/fonts/font_8x16.c
@@ -2316,7 +2316,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 128 0x80 'Ä' */
+	/* 128 0x80 '√á' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x3c, /* 00111100 */
@@ -2334,7 +2334,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 129 0x81 'Å' */
+	/* 129 0x81 '√º' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xcc, /* 11001100 */
@@ -2352,7 +2352,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 130 0x82 'Ç' */
+	/* 130 0x82 '√©' */
 	0x00, /* 00000000 */
 	0x0c, /* 00001100 */
 	0x18, /* 00011000 */
@@ -2370,7 +2370,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 131 0x83 'É' */
+	/* 131 0x83 '√¢' */
 	0x00, /* 00000000 */
 	0x10, /* 00010000 */
 	0x38, /* 00111000 */
@@ -2388,7 +2388,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 132 0x84 'Ñ' */
+	/* 132 0x84 '√§' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xcc, /* 11001100 */
@@ -2406,7 +2406,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 133 0x85 'Ö' */
+	/* 133 0x85 '√†' */
 	0x00, /* 00000000 */
 	0x60, /* 01100000 */
 	0x30, /* 00110000 */
@@ -2424,7 +2424,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 134 0x86 'Ü' */
+	/* 134 0x86 '√•' */
 	0x00, /* 00000000 */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
@@ -2442,7 +2442,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 135 0x87 'á' */
+	/* 135 0x87 '√ß' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -2460,7 +2460,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 136 0x88 'à' */
+	/* 136 0x88 '√™' */
 	0x00, /* 00000000 */
 	0x10, /* 00010000 */
 	0x38, /* 00111000 */
@@ -2478,7 +2478,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 137 0x89 'â' */
+	/* 137 0x89 '√´' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xc6, /* 11000110 */
@@ -2496,7 +2496,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 138 0x8a 'ä' */
+	/* 138 0x8a '√®' */
 	0x00, /* 00000000 */
 	0x60, /* 01100000 */
 	0x30, /* 00110000 */
@@ -2514,7 +2514,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 139 0x8b 'ã' */
+	/* 139 0x8b '√Ø' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x66, /* 01100110 */
@@ -2532,7 +2532,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 140 0x8c 'å' */
+	/* 140 0x8c '√Æ' */
 	0x00, /* 00000000 */
 	0x18, /* 00011000 */
 	0x3c, /* 00111100 */
@@ -2550,7 +2550,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 141 0x8d 'ç' */
+	/* 141 0x8d '√¨' */
 	0x00, /* 00000000 */
 	0x60, /* 01100000 */
 	0x30, /* 00110000 */
@@ -2568,7 +2568,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 142 0x8e 'é' */
+	/* 142 0x8e '√Ñ' */
 	0x00, /* 00000000 */
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
@@ -2586,7 +2586,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 143 0x8f 'è' */
+	/* 143 0x8f '√Ö' */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
 	0x38, /* 00111000 */
@@ -2604,7 +2604,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 144 0x90 'ê' */
+	/* 144 0x90 '√â' */
 	0x0c, /* 00001100 */
 	0x18, /* 00011000 */
 	0x00, /* 00000000 */
@@ -2622,7 +2622,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 145 0x91 'ë' */
+	/* 145 0x91 '√¶' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -2640,7 +2640,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 146 0x92 'í' */
+	/* 146 0x92 '√Ü' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x3e, /* 00111110 */
@@ -2658,7 +2658,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 147 0x93 'ì' */
+	/* 147 0x93 '√¥' */
 	0x00, /* 00000000 */
 	0x10, /* 00010000 */
 	0x38, /* 00111000 */
@@ -2676,7 +2676,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 148 0x94 'î' */
+	/* 148 0x94 '√∂' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xc6, /* 11000110 */
@@ -2694,7 +2694,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 149 0x95 'ï' */
+	/* 149 0x95 '√≤' */
 	0x00, /* 00000000 */
 	0x60, /* 01100000 */
 	0x30, /* 00110000 */
@@ -2712,7 +2712,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 150 0x96 'ñ' */
+	/* 150 0x96 '√ª' */
 	0x00, /* 00000000 */
 	0x30, /* 00110000 */
 	0x78, /* 01111000 */
@@ -2730,7 +2730,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 151 0x97 'ó' */
+	/* 151 0x97 '√π' */
 	0x00, /* 00000000 */
 	0x60, /* 01100000 */
 	0x30, /* 00110000 */
@@ -2748,7 +2748,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 152 0x98 'ò' */
+	/* 152 0x98 '√ø' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xc6, /* 11000110 */
@@ -2766,7 +2766,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x78, /* 01111000 */
 	0x00, /* 00000000 */
 
-	/* 153 0x99 'ô' */
+	/* 153 0x99 '√ñ' */
 	0x00, /* 00000000 */
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
@@ -2784,7 +2784,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 154 0x9a 'ö' */
+	/* 154 0x9a '√ú' */
 	0x00, /* 00000000 */
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
@@ -2802,7 +2802,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 155 0x9b 'õ' */
+	/* 155 0x9b '¬¢' */
 	0x00, /* 00000000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -2820,7 +2820,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 156 0x9c 'ú' */
+	/* 156 0x9c '¬£' */
 	0x00, /* 00000000 */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
@@ -2838,7 +2838,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 157 0x9d 'ù' */
+	/* 157 0x9d '¬•' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x66, /* 01100110 */
@@ -2856,7 +2856,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 158 0x9e 'û' */
+	/* 158 0x9e '‚Çß' */
 	0x00, /* 00000000 */
 	0xf8, /* 11111000 */
 	0xcc, /* 11001100 */
@@ -2874,7 +2874,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 159 0x9f 'ü' */
+	/* 159 0x9f '∆í' */
 	0x00, /* 00000000 */
 	0x0e, /* 00001110 */
 	0x1b, /* 00011011 */
@@ -2892,7 +2892,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 160 0xa0 '†' */
+	/* 160 0xa0 '√°' */
 	0x00, /* 00000000 */
 	0x18, /* 00011000 */
 	0x30, /* 00110000 */
@@ -2910,7 +2910,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 161 0xa1 '°' */
+	/* 161 0xa1 '√≠' */
 	0x00, /* 00000000 */
 	0x0c, /* 00001100 */
 	0x18, /* 00011000 */
@@ -2928,7 +2928,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 162 0xa2 '¢' */
+	/* 162 0xa2 '√≥' */
 	0x00, /* 00000000 */
 	0x18, /* 00011000 */
 	0x30, /* 00110000 */
@@ -2946,7 +2946,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 163 0xa3 '£' */
+	/* 163 0xa3 '√∫' */
 	0x00, /* 00000000 */
 	0x18, /* 00011000 */
 	0x30, /* 00110000 */
@@ -2964,7 +2964,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 164 0xa4 '§' */
+	/* 164 0xa4 '√±' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x76, /* 01110110 */
@@ -2982,7 +2982,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 165 0xa5 '•' */
+	/* 165 0xa5 '√ë' */
 	0x76, /* 01110110 */
 	0xdc, /* 11011100 */
 	0x00, /* 00000000 */
@@ -3000,7 +3000,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 166 0xa6 '¶' */
+	/* 166 0xa6 '¬™' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x3c, /* 00111100 */
@@ -3018,7 +3018,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 167 0xa7 'ß' */
+	/* 167 0xa7 '¬∫' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x38, /* 00111000 */
@@ -3036,7 +3036,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 168 0xa8 '®' */
+	/* 168 0xa8 '¬ø' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x30, /* 00110000 */
@@ -3054,7 +3054,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 169 0xa9 '©' */
+	/* 169 0xa9 '‚åê' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3072,7 +3072,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 170 0xaa '™' */
+	/* 170 0xaa '¬¨' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3090,7 +3090,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 171 0xab '´' */
+	/* 171 0xab '¬Ω' */
 	0x00, /* 00000000 */
 	0x60, /* 01100000 */
 	0xe0, /* 11100000 */
@@ -3108,7 +3108,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 172 0xac '¨' */
+	/* 172 0xac '¬º' */
 	0x00, /* 00000000 */
 	0x60, /* 01100000 */
 	0xe0, /* 11100000 */
@@ -3126,7 +3126,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 173 0xad '≠' */
+	/* 173 0xad '¬°' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x18, /* 00011000 */
@@ -3144,7 +3144,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 174 0xae 'Æ' */
+	/* 174 0xae '¬´' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3162,7 +3162,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 175 0xaf 'Ø' */
+	/* 175 0xaf '¬ª' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3180,7 +3180,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 176 0xb0 '∞' */
+	/* 176 0xb0 '‚ñë' */
 	0x11, /* 00010001 */
 	0x44, /* 01000100 */
 	0x11, /* 00010001 */
@@ -3198,7 +3198,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x11, /* 00010001 */
 	0x44, /* 01000100 */
 
-	/* 177 0xb1 '±' */
+	/* 177 0xb1 '‚ñí' */
 	0x55, /* 01010101 */
 	0xaa, /* 10101010 */
 	0x55, /* 01010101 */
@@ -3216,7 +3216,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x55, /* 01010101 */
 	0xaa, /* 10101010 */
 
-	/* 178 0xb2 '≤' */
+	/* 178 0xb2 '‚ñì' */
 	0xdd, /* 11011101 */
 	0x77, /* 01110111 */
 	0xdd, /* 11011101 */
@@ -3234,7 +3234,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0xdd, /* 11011101 */
 	0x77, /* 01110111 */
 
-	/* 179 0xb3 '≥' */
+	/* 179 0xb3 '‚îÇ' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3252,7 +3252,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 180 0xb4 '¥' */
+	/* 180 0xb4 '‚î§' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3270,7 +3270,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 181 0xb5 'µ' */
+	/* 181 0xb5 '‚ï°' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3288,7 +3288,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 182 0xb6 '∂' */
+	/* 182 0xb6 '‚ï¢' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3306,7 +3306,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 183 0xb7 '∑' */
+	/* 183 0xb7 '‚ïñ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3324,7 +3324,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 184 0xb8 '∏' */
+	/* 184 0xb8 '‚ïï' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3342,7 +3342,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 185 0xb9 'π' */
+	/* 185 0xb9 '‚ï£' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3360,7 +3360,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 186 0xba '∫' */
+	/* 186 0xba '‚ïë' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3378,7 +3378,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 187 0xbb 'ª' */
+	/* 187 0xbb '‚ïó' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3396,7 +3396,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 188 0xbc 'º' */
+	/* 188 0xbc '‚ïù' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3414,7 +3414,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 189 0xbd 'Ω' */
+	/* 189 0xbd '‚ïú' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3432,7 +3432,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 190 0xbe 'æ' */
+	/* 190 0xbe '‚ïõ' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3450,7 +3450,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 191 0xbf 'ø' */
+	/* 191 0xbf '‚îê' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3468,7 +3468,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 192 0xc0 '¿' */
+	/* 192 0xc0 '‚îî' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3486,7 +3486,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 193 0xc1 '¡' */
+	/* 193 0xc1 '‚î¥' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3504,7 +3504,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 194 0xc2 '¬' */
+	/* 194 0xc2 '‚î¨' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3522,7 +3522,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 195 0xc3 '√' */
+	/* 195 0xc3 '‚îú' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3540,7 +3540,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 196 0xc4 'ƒ' */
+	/* 196 0xc4 '‚îÄ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3558,7 +3558,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 197 0xc5 '≈' */
+	/* 197 0xc5 '‚îº' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3576,7 +3576,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 198 0xc6 '∆' */
+	/* 198 0xc6 '‚ïû' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3594,7 +3594,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 199 0xc7 '«' */
+	/* 199 0xc7 '‚ïü' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3612,7 +3612,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 200 0xc8 '»' */
+	/* 200 0xc8 '‚ïö' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3630,7 +3630,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 201 0xc9 '…' */
+	/* 201 0xc9 '‚ïî' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3648,7 +3648,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 202 0xca ' ' */
+	/* 202 0xca '‚ï©' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3666,7 +3666,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 203 0xcb 'À' */
+	/* 203 0xcb '‚ï¶' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3684,7 +3684,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 204 0xcc 'Ã' */
+	/* 204 0xcc '‚ï†' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3702,7 +3702,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 205 0xcd 'Õ' */
+	/* 205 0xcd '‚ïê' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3720,7 +3720,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 206 0xce 'Œ' */
+	/* 206 0xce '‚ï¨' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3738,7 +3738,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 207 0xcf 'œ' */
+	/* 207 0xcf '‚ïß' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3756,7 +3756,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 208 0xd0 '–' */
+	/* 208 0xd0 '‚ï®' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3774,7 +3774,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 209 0xd1 '—' */
+	/* 209 0xd1 '‚ï§' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3792,7 +3792,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 210 0xd2 '“' */
+	/* 210 0xd2 '‚ï•' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3810,7 +3810,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 211 0xd3 '”' */
+	/* 211 0xd3 '‚ïô' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3828,7 +3828,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 212 0xd4 '‘' */
+	/* 212 0xd4 '‚ïò' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3846,7 +3846,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 213 0xd5 '’' */
+	/* 213 0xd5 '‚ïí' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3864,7 +3864,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 214 0xd6 '÷' */
+	/* 214 0xd6 '‚ïì' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3882,7 +3882,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 215 0xd7 '◊' */
+	/* 215 0xd7 '‚ï´' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -3900,7 +3900,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 216 0xd8 'ÿ' */
+	/* 216 0xd8 '‚ï™' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3918,7 +3918,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 217 0xd9 'Ÿ' */
+	/* 217 0xd9 '‚îò' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -3936,7 +3936,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 218 0xda '⁄' */
+	/* 218 0xda '‚îå' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3954,7 +3954,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 219 0xdb '€' */
+	/* 219 0xdb '‚ñà' */
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
@@ -3972,7 +3972,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
 
-	/* 220 0xdc '‹' */
+	/* 220 0xdc '‚ñÑ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -3990,7 +3990,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
 
-	/* 221 0xdd '›' */
+	/* 221 0xdd '‚ñå' */
 	0xf0, /* 11110000 */
 	0xf0, /* 11110000 */
 	0xf0, /* 11110000 */
@@ -4008,7 +4008,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0xf0, /* 11110000 */
 	0xf0, /* 11110000 */
 
-	/* 222 0xde 'ﬁ' */
+	/* 222 0xde '‚ñê' */
 	0x0f, /* 00001111 */
 	0x0f, /* 00001111 */
 	0x0f, /* 00001111 */
@@ -4026,7 +4026,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x0f, /* 00001111 */
 	0x0f, /* 00001111 */
 
-	/* 223 0xdf 'ﬂ' */
+	/* 223 0xdf '‚ñÄ' */
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
@@ -4044,7 +4044,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 224 0xe0 '‡' */
+	/* 224 0xe0 'Œ±' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4062,7 +4062,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 225 0xe1 '·' */
+	/* 225 0xe1 '√ü' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x78, /* 01111000 */
@@ -4080,7 +4080,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 226 0xe2 '‚' */
+	/* 226 0xe2 'Œì' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xfe, /* 11111110 */
@@ -4098,7 +4098,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 227 0xe3 '„' */
+	/* 227 0xe3 'œÄ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4116,7 +4116,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 228 0xe4 '‰' */
+	/* 228 0xe4 'Œ£' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xfe, /* 11111110 */
@@ -4134,7 +4134,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 229 0xe5 'Â' */
+	/* 229 0xe5 'œÉ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4152,7 +4152,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 230 0xe6 'Ê' */
+	/* 230 0xe6 '¬µ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4170,7 +4170,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0xc0, /* 11000000 */
 	0x00, /* 00000000 */
 
-	/* 231 0xe7 'Á' */
+	/* 231 0xe7 'œÑ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4188,7 +4188,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 232 0xe8 'Ë' */
+	/* 232 0xe8 'Œ¶' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x7e, /* 01111110 */
@@ -4206,7 +4206,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 233 0xe9 'È' */
+	/* 233 0xe9 'Œò' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x38, /* 00111000 */
@@ -4224,7 +4224,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 234 0xea 'Í' */
+	/* 234 0xea 'Œ©' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x38, /* 00111000 */
@@ -4242,7 +4242,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 235 0xeb 'Î' */
+	/* 235 0xeb 'Œ¥' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x1e, /* 00011110 */
@@ -4260,7 +4260,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 236 0xec 'Ï' */
+	/* 236 0xec '‚àû' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4278,7 +4278,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 237 0xed 'Ì' */
+	/* 237 0xed 'œÜ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4296,7 +4296,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 238 0xee 'Ó' */
+	/* 238 0xee 'Œµ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x1c, /* 00011100 */
@@ -4314,7 +4314,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 239 0xef 'Ô' */
+	/* 239 0xef '‚à©' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4332,7 +4332,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 240 0xf0 '' */
+	/* 240 0xf0 '‚â°' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4350,7 +4350,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 241 0xf1 'Ò' */
+	/* 241 0xf1 '¬±' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4368,7 +4368,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 242 0xf2 'Ú' */
+	/* 242 0xf2 '‚â•' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4386,7 +4386,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 243 0xf3 'Û' */
+	/* 243 0xf3 '‚â§' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4404,7 +4404,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 244 0xf4 'Ù' */
+	/* 244 0xf4 '‚å†' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x0e, /* 00001110 */
@@ -4422,7 +4422,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 245 0xf5 'ı' */
+	/* 245 0xf5 '‚å°' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -4440,7 +4440,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 246 0xf6 'ˆ' */
+	/* 246 0xf6 '√∑' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4458,7 +4458,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 247 0xf7 '˜' */
+	/* 247 0xf7 '‚âà' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4476,7 +4476,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 248 0xf8 '¯' */
+	/* 248 0xf8 '¬∞' */
 	0x00, /* 00000000 */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
@@ -4494,7 +4494,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 249 0xf9 '˘' */
+	/* 249 0xf9 '¬∑' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4512,7 +4512,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 250 0xfa '˙' */
+	/* 250 0xfa '‚Ä¢' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4530,7 +4530,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 251 0xfb '˚' */
+	/* 251 0xfb '‚àö' */
 	0x00, /* 00000000 */
 	0x0f, /* 00001111 */
 	0x0c, /* 00001100 */
@@ -4548,7 +4548,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 252 0xfc '¸' */
+	/* 252 0xfc '‚Åø' */
 	0x00, /* 00000000 */
 	0x6c, /* 01101100 */
 	0x36, /* 00110110 */
@@ -4566,7 +4566,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 253 0xfd '˝' */
+	/* 253 0xfd '¬≤' */
 	0x00, /* 00000000 */
 	0x3c, /* 00111100 */
 	0x66, /* 01100110 */
@@ -4584,7 +4584,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 254 0xfe '˛' */
+	/* 254 0xfe '‚ñ†' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -4602,7 +4602,7 @@ static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 255 0xff 'ˇ' */
+	/* 255 0xff '¬†' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
diff --git a/lib/fonts/font_8x8.c b/lib/fonts/font_8x8.c
index 751becf3c521..2328ebc8bab5 100644
--- a/lib/fonts/font_8x8.c
+++ b/lib/fonts/font_8x8.c
@@ -1291,7 +1291,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xfe, /* 11111110 */
 	0x00, /* 00000000 */
 
-	/* 128 0x80 'Ä' */
+	/* 128 0x80 '√á' */
 	0x7c, /* 01111100 */
 	0xc6, /* 11000110 */
 	0xc0, /* 11000000 */
@@ -1301,7 +1301,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x0c, /* 00001100 */
 	0x78, /* 01111000 */
 
-	/* 129 0x81 'Å' */
+	/* 129 0x81 '√º' */
 	0xcc, /* 11001100 */
 	0x00, /* 00000000 */
 	0xcc, /* 11001100 */
@@ -1311,7 +1311,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 130 0x82 'Ç' */
+	/* 130 0x82 '√©' */
 	0x0c, /* 00001100 */
 	0x18, /* 00011000 */
 	0x7c, /* 01111100 */
@@ -1321,7 +1321,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0x00, /* 00000000 */
 
-	/* 131 0x83 'É' */
+	/* 131 0x83 '√¢' */
 	0x7c, /* 01111100 */
 	0x82, /* 10000010 */
 	0x78, /* 01111000 */
@@ -1331,7 +1331,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 132 0x84 'Ñ' */
+	/* 132 0x84 '√§' */
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
 	0x78, /* 01111000 */
@@ -1341,7 +1341,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 133 0x85 'Ö' */
+	/* 133 0x85 '√†' */
 	0x30, /* 00110000 */
 	0x18, /* 00011000 */
 	0x78, /* 01111000 */
@@ -1351,7 +1351,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 134 0x86 'Ü' */
+	/* 134 0x86 '√•' */
 	0x30, /* 00110000 */
 	0x30, /* 00110000 */
 	0x78, /* 01111000 */
@@ -1361,7 +1361,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 135 0x87 'á' */
+	/* 135 0x87 '√ß' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x7e, /* 01111110 */
@@ -1371,7 +1371,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x0c, /* 00001100 */
 	0x38, /* 00111000 */
 
-	/* 136 0x88 'à' */
+	/* 136 0x88 '√™' */
 	0x7c, /* 01111100 */
 	0x82, /* 10000010 */
 	0x7c, /* 01111100 */
@@ -1381,7 +1381,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0x00, /* 00000000 */
 
-	/* 137 0x89 'â' */
+	/* 137 0x89 '√´' */
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
 	0x7c, /* 01111100 */
@@ -1391,7 +1391,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0x00, /* 00000000 */
 
-	/* 138 0x8a 'ä' */
+	/* 138 0x8a '√®' */
 	0x30, /* 00110000 */
 	0x18, /* 00011000 */
 	0x7c, /* 01111100 */
@@ -1401,7 +1401,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0x00, /* 00000000 */
 
-	/* 139 0x8b 'ã' */
+	/* 139 0x8b '√Ø' */
 	0x66, /* 01100110 */
 	0x00, /* 00000000 */
 	0x38, /* 00111000 */
@@ -1411,7 +1411,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x3c, /* 00111100 */
 	0x00, /* 00000000 */
 
-	/* 140 0x8c 'å' */
+	/* 140 0x8c '√Æ' */
 	0x7c, /* 01111100 */
 	0x82, /* 10000010 */
 	0x38, /* 00111000 */
@@ -1421,7 +1421,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x3c, /* 00111100 */
 	0x00, /* 00000000 */
 
-	/* 141 0x8d 'ç' */
+	/* 141 0x8d '√¨' */
 	0x30, /* 00110000 */
 	0x18, /* 00011000 */
 	0x00, /* 00000000 */
@@ -1431,7 +1431,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x3c, /* 00111100 */
 	0x00, /* 00000000 */
 
-	/* 142 0x8e 'é' */
+	/* 142 0x8e '√Ñ' */
 	0xc6, /* 11000110 */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
@@ -1441,7 +1441,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
 
-	/* 143 0x8f 'è' */
+	/* 143 0x8f '√Ö' */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
 	0x7c, /* 01111100 */
@@ -1451,7 +1451,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
 
-	/* 144 0x90 'ê' */
+	/* 144 0x90 '√â' */
 	0x18, /* 00011000 */
 	0x30, /* 00110000 */
 	0xfe, /* 11111110 */
@@ -1461,7 +1461,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xfe, /* 11111110 */
 	0x00, /* 00000000 */
 
-	/* 145 0x91 'ë' */
+	/* 145 0x91 '√¶' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x7e, /* 01111110 */
@@ -1471,7 +1471,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7e, /* 01111110 */
 	0x00, /* 00000000 */
 
-	/* 146 0x92 'í' */
+	/* 146 0x92 '√Ü' */
 	0x3e, /* 00111110 */
 	0x6c, /* 01101100 */
 	0xcc, /* 11001100 */
@@ -1481,7 +1481,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xce, /* 11001110 */
 	0x00, /* 00000000 */
 
-	/* 147 0x93 'ì' */
+	/* 147 0x93 '√¥' */
 	0x7c, /* 01111100 */
 	0x82, /* 10000010 */
 	0x7c, /* 01111100 */
@@ -1491,7 +1491,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0x00, /* 00000000 */
 
-	/* 148 0x94 'î' */
+	/* 148 0x94 '√∂' */
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
 	0x7c, /* 01111100 */
@@ -1501,7 +1501,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0x00, /* 00000000 */
 
-	/* 149 0x95 'ï' */
+	/* 149 0x95 '√≤' */
 	0x30, /* 00110000 */
 	0x18, /* 00011000 */
 	0x7c, /* 01111100 */
@@ -1511,7 +1511,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0x00, /* 00000000 */
 
-	/* 150 0x96 'ñ' */
+	/* 150 0x96 '√ª' */
 	0x78, /* 01111000 */
 	0x84, /* 10000100 */
 	0x00, /* 00000000 */
@@ -1521,7 +1521,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 151 0x97 'ó' */
+	/* 151 0x97 '√π' */
 	0x60, /* 01100000 */
 	0x30, /* 00110000 */
 	0xcc, /* 11001100 */
@@ -1531,7 +1531,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 152 0x98 'ò' */
+	/* 152 0x98 '√ø' */
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
 	0xc6, /* 11000110 */
@@ -1541,7 +1541,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x06, /* 00000110 */
 	0xfc, /* 11111100 */
 
-	/* 153 0x99 'ô' */
+	/* 153 0x99 '√ñ' */
 	0xc6, /* 11000110 */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
@@ -1551,7 +1551,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x38, /* 00111000 */
 	0x00, /* 00000000 */
 
-	/* 154 0x9a 'ö' */
+	/* 154 0x9a '√ú' */
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
 	0xc6, /* 11000110 */
@@ -1561,7 +1561,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0x00, /* 00000000 */
 
-	/* 155 0x9b 'õ' */
+	/* 155 0x9b '¬¢' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x7e, /* 01111110 */
@@ -1571,7 +1571,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 156 0x9c 'ú' */
+	/* 156 0x9c '¬£' */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
 	0x64, /* 01100100 */
@@ -1581,7 +1581,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xfc, /* 11111100 */
 	0x00, /* 00000000 */
 
-	/* 157 0x9d 'ù' */
+	/* 157 0x9d '¬•' */
 	0x66, /* 01100110 */
 	0x66, /* 01100110 */
 	0x3c, /* 00111100 */
@@ -1591,7 +1591,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 158 0x9e 'û' */
+	/* 158 0x9e '‚Çß' */
 	0xf8, /* 11111000 */
 	0xcc, /* 11001100 */
 	0xcc, /* 11001100 */
@@ -1601,7 +1601,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xc6, /* 11000110 */
 	0xc7, /* 11000111 */
 
-	/* 159 0x9f 'ü' */
+	/* 159 0x9f '∆í' */
 	0x0e, /* 00001110 */
 	0x1b, /* 00011011 */
 	0x18, /* 00011000 */
@@ -1611,7 +1611,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x70, /* 01110000 */
 	0x00, /* 00000000 */
 
-	/* 160 0xa0 '†' */
+	/* 160 0xa0 '√°' */
 	0x18, /* 00011000 */
 	0x30, /* 00110000 */
 	0x78, /* 01111000 */
@@ -1621,7 +1621,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 161 0xa1 '°' */
+	/* 161 0xa1 '√≠' */
 	0x0c, /* 00001100 */
 	0x18, /* 00011000 */
 	0x00, /* 00000000 */
@@ -1631,7 +1631,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x3c, /* 00111100 */
 	0x00, /* 00000000 */
 
-	/* 162 0xa2 '¢' */
+	/* 162 0xa2 '√≥' */
 	0x0c, /* 00001100 */
 	0x18, /* 00011000 */
 	0x7c, /* 01111100 */
@@ -1641,7 +1641,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0x00, /* 00000000 */
 
-	/* 163 0xa3 '£' */
+	/* 163 0xa3 '√∫' */
 	0x18, /* 00011000 */
 	0x30, /* 00110000 */
 	0xcc, /* 11001100 */
@@ -1651,7 +1651,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 164 0xa4 '§' */
+	/* 164 0xa4 '√±' */
 	0x76, /* 01110110 */
 	0xdc, /* 11011100 */
 	0x00, /* 00000000 */
@@ -1661,7 +1661,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x66, /* 01100110 */
 	0x00, /* 00000000 */
 
-	/* 165 0xa5 '•' */
+	/* 165 0xa5 '√ë' */
 	0x76, /* 01110110 */
 	0xdc, /* 11011100 */
 	0x00, /* 00000000 */
@@ -1671,7 +1671,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xce, /* 11001110 */
 	0x00, /* 00000000 */
 
-	/* 166 0xa6 '¶' */
+	/* 166 0xa6 '¬™' */
 	0x3c, /* 00111100 */
 	0x6c, /* 01101100 */
 	0x6c, /* 01101100 */
@@ -1681,7 +1681,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 167 0xa7 'ß' */
+	/* 167 0xa7 '¬∫' */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
 	0x6c, /* 01101100 */
@@ -1691,7 +1691,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 168 0xa8 '®' */
+	/* 168 0xa8 '¬ø' */
 	0x18, /* 00011000 */
 	0x00, /* 00000000 */
 	0x18, /* 00011000 */
@@ -1701,7 +1701,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x3e, /* 00111110 */
 	0x00, /* 00000000 */
 
-	/* 169 0xa9 '©' */
+	/* 169 0xa9 '‚åê' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -1711,7 +1711,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 170 0xaa '™' */
+	/* 170 0xaa '¬¨' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -1721,7 +1721,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 171 0xab '´' */
+	/* 171 0xab '¬Ω' */
 	0x63, /* 01100011 */
 	0xe6, /* 11100110 */
 	0x6c, /* 01101100 */
@@ -1731,7 +1731,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xcc, /* 11001100 */
 	0x0f, /* 00001111 */
 
-	/* 172 0xac '¨' */
+	/* 172 0xac '¬º' */
 	0x63, /* 01100011 */
 	0xe6, /* 11100110 */
 	0x6c, /* 01101100 */
@@ -1741,7 +1741,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xdf, /* 11011111 */
 	0x06, /* 00000110 */
 
-	/* 173 0xad '≠' */
+	/* 173 0xad '¬°' */
 	0x18, /* 00011000 */
 	0x00, /* 00000000 */
 	0x18, /* 00011000 */
@@ -1751,7 +1751,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x00, /* 00000000 */
 
-	/* 174 0xae 'Æ' */
+	/* 174 0xae '¬´' */
 	0x00, /* 00000000 */
 	0x33, /* 00110011 */
 	0x66, /* 01100110 */
@@ -1761,7 +1761,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 175 0xaf 'Ø' */
+	/* 175 0xaf '¬ª' */
 	0x00, /* 00000000 */
 	0xcc, /* 11001100 */
 	0x66, /* 01100110 */
@@ -1771,7 +1771,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 176 0xb0 '∞' */
+	/* 176 0xb0 '‚ñë' */
 	0x22, /* 00100010 */
 	0x88, /* 10001000 */
 	0x22, /* 00100010 */
@@ -1781,7 +1781,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x22, /* 00100010 */
 	0x88, /* 10001000 */
 
-	/* 177 0xb1 '±' */
+	/* 177 0xb1 '‚ñí' */
 	0x55, /* 01010101 */
 	0xaa, /* 10101010 */
 	0x55, /* 01010101 */
@@ -1791,7 +1791,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x55, /* 01010101 */
 	0xaa, /* 10101010 */
 
-	/* 178 0xb2 '≤' */
+	/* 178 0xb2 '‚ñì' */
 	0x77, /* 01110111 */
 	0xdd, /* 11011101 */
 	0x77, /* 01110111 */
@@ -1801,7 +1801,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x77, /* 01110111 */
 	0xdd, /* 11011101 */
 
-	/* 179 0xb3 '≥' */
+	/* 179 0xb3 '‚îÇ' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -1811,7 +1811,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 180 0xb4 '¥' */
+	/* 180 0xb4 '‚î§' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -1821,7 +1821,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 181 0xb5 'µ' */
+	/* 181 0xb5 '‚ï°' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0xf8, /* 11111000 */
@@ -1831,7 +1831,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 182 0xb6 '∂' */
+	/* 182 0xb6 '‚ï¢' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -1841,7 +1841,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 183 0xb7 '∑' */
+	/* 183 0xb7 '‚ïñ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -1851,7 +1851,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 184 0xb8 '∏' */
+	/* 184 0xb8 '‚ïï' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xf8, /* 11111000 */
@@ -1861,7 +1861,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 185 0xb9 'π' */
+	/* 185 0xb9 '‚ï£' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0xf6, /* 11110110 */
@@ -1871,7 +1871,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 186 0xba '∫' */
+	/* 186 0xba '‚ïë' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -1881,7 +1881,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 187 0xbb 'ª' */
+	/* 187 0xbb '‚ïó' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xfe, /* 11111110 */
@@ -1891,7 +1891,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 188 0xbc 'º' */
+	/* 188 0xbc '‚ïù' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0xf6, /* 11110110 */
@@ -1901,7 +1901,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 189 0xbd 'Ω' */
+	/* 189 0xbd '‚ïú' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -1911,7 +1911,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 190 0xbe 'æ' */
+	/* 190 0xbe '‚ïõ' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0xf8, /* 11111000 */
@@ -1921,7 +1921,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 191 0xbf 'ø' */
+	/* 191 0xbf '‚îê' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -1931,7 +1931,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 192 0xc0 '¿' */
+	/* 192 0xc0 '‚îî' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -1941,7 +1941,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 193 0xc1 '¡' */
+	/* 193 0xc1 '‚î¥' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -1951,7 +1951,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 194 0xc2 '¬' */
+	/* 194 0xc2 '‚î¨' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -1961,7 +1961,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 195 0xc3 '√' */
+	/* 195 0xc3 '‚îú' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -1971,7 +1971,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 196 0xc4 'ƒ' */
+	/* 196 0xc4 '‚îÄ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -1981,7 +1981,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 197 0xc5 '≈' */
+	/* 197 0xc5 '‚îº' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -1991,7 +1991,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 198 0xc6 '∆' */
+	/* 198 0xc6 '‚ïû' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x1f, /* 00011111 */
@@ -2001,7 +2001,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 199 0xc7 '«' */
+	/* 199 0xc7 '‚ïü' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -2011,7 +2011,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 200 0xc8 '»' */
+	/* 200 0xc8 '‚ïö' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x37, /* 00110111 */
@@ -2021,7 +2021,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 201 0xc9 '…' */
+	/* 201 0xc9 '‚ïî' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x3f, /* 00111111 */
@@ -2031,7 +2031,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 202 0xca ' ' */
+	/* 202 0xca '‚ï©' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0xf7, /* 11110111 */
@@ -2041,7 +2041,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 203 0xcb 'À' */
+	/* 203 0xcb '‚ï¶' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xff, /* 11111111 */
@@ -2051,7 +2051,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 204 0xcc 'Ã' */
+	/* 204 0xcc '‚ï†' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x37, /* 00110111 */
@@ -2061,7 +2061,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 205 0xcd 'Õ' */
+	/* 205 0xcd '‚ïê' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xff, /* 11111111 */
@@ -2071,7 +2071,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 206 0xce 'Œ' */
+	/* 206 0xce '‚ï¨' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0xf7, /* 11110111 */
@@ -2081,7 +2081,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 207 0xcf 'œ' */
+	/* 207 0xcf '‚ïß' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0xff, /* 11111111 */
@@ -2091,7 +2091,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 208 0xd0 '–' */
+	/* 208 0xd0 '‚ï®' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -2101,7 +2101,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 209 0xd1 '—' */
+	/* 209 0xd1 '‚ï§' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xff, /* 11111111 */
@@ -2111,7 +2111,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 210 0xd2 '“' */
+	/* 210 0xd2 '‚ï•' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -2121,7 +2121,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 211 0xd3 '”' */
+	/* 211 0xd3 '‚ïô' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -2131,7 +2131,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 212 0xd4 '‘' */
+	/* 212 0xd4 '‚ïò' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x1f, /* 00011111 */
@@ -2141,7 +2141,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 213 0xd5 '’' */
+	/* 213 0xd5 '‚ïí' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x1f, /* 00011111 */
@@ -2151,7 +2151,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 214 0xd6 '÷' */
+	/* 214 0xd6 '‚ïì' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -2161,7 +2161,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 215 0xd7 '◊' */
+	/* 215 0xd7 '‚ï´' */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -2171,7 +2171,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
 
-	/* 216 0xd8 'ÿ' */
+	/* 216 0xd8 '‚ï™' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0xff, /* 11111111 */
@@ -2181,7 +2181,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 217 0xd9 'Ÿ' */
+	/* 217 0xd9 '‚îò' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -2191,7 +2191,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 218 0xda '⁄' */
+	/* 218 0xda '‚îå' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -2201,7 +2201,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 219 0xdb '€' */
+	/* 219 0xdb '‚ñà' */
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
@@ -2211,7 +2211,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
 
-	/* 220 0xdc '‹' */
+	/* 220 0xdc '‚ñÑ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -2221,7 +2221,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
 
-	/* 221 0xdd '›' */
+	/* 221 0xdd '‚ñå' */
 	0xf0, /* 11110000 */
 	0xf0, /* 11110000 */
 	0xf0, /* 11110000 */
@@ -2231,7 +2231,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xf0, /* 11110000 */
 	0xf0, /* 11110000 */
 
-	/* 222 0xde 'ﬁ' */
+	/* 222 0xde '‚ñê' */
 	0x0f, /* 00001111 */
 	0x0f, /* 00001111 */
 	0x0f, /* 00001111 */
@@ -2241,7 +2241,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x0f, /* 00001111 */
 	0x0f, /* 00001111 */
 
-	/* 223 0xdf 'ﬂ' */
+	/* 223 0xdf '‚ñÄ' */
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
 	0xff, /* 11111111 */
@@ -2251,7 +2251,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 224 0xe0 '‡' */
+	/* 224 0xe0 'Œ±' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x76, /* 01110110 */
@@ -2261,7 +2261,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x76, /* 01110110 */
 	0x00, /* 00000000 */
 
-	/* 225 0xe1 '·' */
+	/* 225 0xe1 '√ü' */
 	0x78, /* 01111000 */
 	0xcc, /* 11001100 */
 	0xcc, /* 11001100 */
@@ -2271,7 +2271,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xcc, /* 11001100 */
 	0x00, /* 00000000 */
 
-	/* 226 0xe2 '‚' */
+	/* 226 0xe2 'Œì' */
 	0xfe, /* 11111110 */
 	0xc6, /* 11000110 */
 	0xc0, /* 11000000 */
@@ -2281,7 +2281,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xc0, /* 11000000 */
 	0x00, /* 00000000 */
 
-	/* 227 0xe3 '„' */
+	/* 227 0xe3 'œÄ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0xfe, /* 11111110 */
@@ -2291,7 +2291,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x6c, /* 01101100 */
 	0x00, /* 00000000 */
 
-	/* 228 0xe4 '‰' */
+	/* 228 0xe4 'Œ£' */
 	0xfe, /* 11111110 */
 	0xc6, /* 11000110 */
 	0x60, /* 01100000 */
@@ -2301,7 +2301,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xfe, /* 11111110 */
 	0x00, /* 00000000 */
 
-	/* 229 0xe5 'Â' */
+	/* 229 0xe5 'œÉ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x7e, /* 01111110 */
@@ -2311,7 +2311,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x70, /* 01110000 */
 	0x00, /* 00000000 */
 
-	/* 230 0xe6 'Ê' */
+	/* 230 0xe6 '¬µ' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x66, /* 01100110 */
@@ -2321,7 +2321,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7c, /* 01111100 */
 	0xc0, /* 11000000 */
 
-	/* 231 0xe7 'Á' */
+	/* 231 0xe7 'œÑ' */
 	0x00, /* 00000000 */
 	0x76, /* 01110110 */
 	0xdc, /* 11011100 */
@@ -2331,7 +2331,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x00, /* 00000000 */
 
-	/* 232 0xe8 'Ë' */
+	/* 232 0xe8 'Œ¶' */
 	0x7e, /* 01111110 */
 	0x18, /* 00011000 */
 	0x3c, /* 00111100 */
@@ -2341,7 +2341,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x7e, /* 01111110 */
 
-	/* 233 0xe9 'È' */
+	/* 233 0xe9 'Œò' */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
 	0xc6, /* 11000110 */
@@ -2351,7 +2351,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x38, /* 00111000 */
 	0x00, /* 00000000 */
 
-	/* 234 0xea 'Í' */
+	/* 234 0xea 'Œ©' */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
 	0xc6, /* 11000110 */
@@ -2361,7 +2361,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xee, /* 11101110 */
 	0x00, /* 00000000 */
 
-	/* 235 0xeb 'Î' */
+	/* 235 0xeb 'Œ¥' */
 	0x0e, /* 00001110 */
 	0x18, /* 00011000 */
 	0x0c, /* 00001100 */
@@ -2371,7 +2371,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x3c, /* 00111100 */
 	0x00, /* 00000000 */
 
-	/* 236 0xec 'Ï' */
+	/* 236 0xec '‚àû' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x7e, /* 01111110 */
@@ -2381,7 +2381,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 237 0xed 'Ì' */
+	/* 237 0xed 'œÜ' */
 	0x06, /* 00000110 */
 	0x0c, /* 00001100 */
 	0x7e, /* 01111110 */
@@ -2391,7 +2391,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x60, /* 01100000 */
 	0xc0, /* 11000000 */
 
-	/* 238 0xee 'Ó' */
+	/* 238 0xee 'Œµ' */
 	0x1e, /* 00011110 */
 	0x30, /* 00110000 */
 	0x60, /* 01100000 */
@@ -2401,7 +2401,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x1e, /* 00011110 */
 	0x00, /* 00000000 */
 
-	/* 239 0xef 'Ô' */
+	/* 239 0xef '‚à©' */
 	0x00, /* 00000000 */
 	0x7c, /* 01111100 */
 	0xc6, /* 11000110 */
@@ -2411,7 +2411,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xc6, /* 11000110 */
 	0x00, /* 00000000 */
 
-	/* 240 0xf0 '' */
+	/* 240 0xf0 '‚â°' */
 	0x00, /* 00000000 */
 	0xfe, /* 11111110 */
 	0x00, /* 00000000 */
@@ -2421,7 +2421,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 241 0xf1 'Ò' */
+	/* 241 0xf1 '¬±' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x7e, /* 01111110 */
@@ -2431,7 +2431,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7e, /* 01111110 */
 	0x00, /* 00000000 */
 
-	/* 242 0xf2 'Ú' */
+	/* 242 0xf2 '‚â•' */
 	0x30, /* 00110000 */
 	0x18, /* 00011000 */
 	0x0c, /* 00001100 */
@@ -2441,7 +2441,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7e, /* 01111110 */
 	0x00, /* 00000000 */
 
-	/* 243 0xf3 'Û' */
+	/* 243 0xf3 '‚â§' */
 	0x0c, /* 00001100 */
 	0x18, /* 00011000 */
 	0x30, /* 00110000 */
@@ -2451,7 +2451,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x7e, /* 01111110 */
 	0x00, /* 00000000 */
 
-	/* 244 0xf4 'Ù' */
+	/* 244 0xf4 '‚å†' */
 	0x0e, /* 00001110 */
 	0x1b, /* 00011011 */
 	0x1b, /* 00011011 */
@@ -2461,7 +2461,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 
-	/* 245 0xf5 'ı' */
+	/* 245 0xf5 '‚å°' */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
 	0x18, /* 00011000 */
@@ -2471,7 +2471,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0xd8, /* 11011000 */
 	0x70, /* 01110000 */
 
-	/* 246 0xf6 'ˆ' */
+	/* 246 0xf6 '√∑' */
 	0x00, /* 00000000 */
 	0x18, /* 00011000 */
 	0x00, /* 00000000 */
@@ -2481,7 +2481,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 247 0xf7 '˜' */
+	/* 247 0xf7 '‚âà' */
 	0x00, /* 00000000 */
 	0x76, /* 01110110 */
 	0xdc, /* 11011100 */
@@ -2491,7 +2491,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 248 0xf8 '¯' */
+	/* 248 0xf8 '¬∞' */
 	0x38, /* 00111000 */
 	0x6c, /* 01101100 */
 	0x6c, /* 01101100 */
@@ -2501,7 +2501,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 249 0xf9 '˘' */
+	/* 249 0xf9 '¬∑' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -2511,7 +2511,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 250 0xfa '˙' */
+	/* 250 0xfa '‚Ä¢' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
@@ -2521,7 +2521,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 251 0xfb '˚' */
+	/* 251 0xfb '‚àö' */
 	0x0f, /* 00001111 */
 	0x0c, /* 00001100 */
 	0x0c, /* 00001100 */
@@ -2531,7 +2531,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x3c, /* 00111100 */
 	0x1c, /* 00011100 */
 
-	/* 252 0xfc '¸' */
+	/* 252 0xfc '‚Åø' */
 	0x6c, /* 01101100 */
 	0x36, /* 00110110 */
 	0x36, /* 00110110 */
@@ -2541,7 +2541,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 253 0xfd '˝' */
+	/* 253 0xfd '¬≤' */
 	0x78, /* 01111000 */
 	0x0c, /* 00001100 */
 	0x18, /* 00011000 */
@@ -2551,7 +2551,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 254 0xfe '˛' */
+	/* 254 0xfe '‚ñ†' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x3c, /* 00111100 */
@@ -2561,7 +2561,7 @@ static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 
-	/* 255 0xff 'ˇ' */
+	/* 255 0xff '¬†' */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
 	0x00, /* 00000000 */
diff --git a/lib/fonts/font_pearl_8x8.c b/lib/fonts/font_pearl_8x8.c
index b0514c0a7445..b15d3c342c5b 100644
--- a/lib/fonts/font_pearl_8x8.c
+++ b/lib/fonts/font_pearl_8x8.c
@@ -1296,7 +1296,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xfe, /* 11111110 */
    0x00, /* 00000000 */
 
-   /* 128 0x80 'Ä' */
+   /* 128 0x80 '√á' */
    0x7c, /* 01111100 */
    0xc6, /* 11000110 */
    0xc0, /* 11000000 */
@@ -1306,7 +1306,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x0c, /* 00001100 */
    0x78, /* 01111000 */
 
-   /* 129 0x81 'Å' */
+   /* 129 0x81 '√º' */
    0xcc, /* 11001100 */
    0x00, /* 00000000 */
    0xcc, /* 11001100 */
@@ -1316,7 +1316,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 130 0x82 'Ç' */
+   /* 130 0x82 '√©' */
    0x0c, /* 00001100 */
    0x18, /* 00011000 */
    0x7c, /* 01111100 */
@@ -1326,7 +1326,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0x00, /* 00000000 */
 
-   /* 131 0x83 'É' */
+   /* 131 0x83 '√¢' */
    0x7c, /* 01111100 */
    0x82, /* 10000010 */
    0x78, /* 01111000 */
@@ -1336,7 +1336,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 132 0x84 'Ñ' */
+   /* 132 0x84 '√§' */
    0xc6, /* 11000110 */
    0x00, /* 00000000 */
    0x78, /* 01111000 */
@@ -1346,7 +1346,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 133 0x85 'Ö' */
+   /* 133 0x85 '√†' */
    0x30, /* 00110000 */
    0x18, /* 00011000 */
    0x78, /* 01111000 */
@@ -1356,7 +1356,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 134 0x86 'Ü' */
+   /* 134 0x86 '√•' */
    0x30, /* 00110000 */
    0x30, /* 00110000 */
    0x78, /* 01111000 */
@@ -1366,7 +1366,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 135 0x87 'á' */
+   /* 135 0x87 '√ß' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x7e, /* 01111110 */
@@ -1376,7 +1376,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x0c, /* 00001100 */
    0x38, /* 00111000 */
 
-   /* 136 0x88 'à' */
+   /* 136 0x88 '√™' */
    0x7c, /* 01111100 */
    0x82, /* 10000010 */
    0x7c, /* 01111100 */
@@ -1386,7 +1386,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0x00, /* 00000000 */
 
-   /* 137 0x89 'â' */
+   /* 137 0x89 '√´' */
    0xc6, /* 11000110 */
    0x00, /* 00000000 */
    0x7c, /* 01111100 */
@@ -1396,7 +1396,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0x00, /* 00000000 */
 
-   /* 138 0x8a 'ä' */
+   /* 138 0x8a '√®' */
    0x30, /* 00110000 */
    0x18, /* 00011000 */
    0x7c, /* 01111100 */
@@ -1406,7 +1406,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0x00, /* 00000000 */
 
-   /* 139 0x8b 'ã' */
+   /* 139 0x8b '√Ø' */
    0x66, /* 01100110 */
    0x00, /* 00000000 */
    0x38, /* 00111000 */
@@ -1416,7 +1416,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x3c, /* 00111100 */
    0x00, /* 00000000 */
 
-   /* 140 0x8c 'å' */
+   /* 140 0x8c '√Æ' */
    0x7c, /* 01111100 */
    0x82, /* 10000010 */
    0x38, /* 00111000 */
@@ -1426,7 +1426,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x3c, /* 00111100 */
    0x00, /* 00000000 */
 
-   /* 141 0x8d 'ç' */
+   /* 141 0x8d '√¨' */
    0x30, /* 00110000 */
    0x18, /* 00011000 */
    0x00, /* 00000000 */
@@ -1436,7 +1436,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x3c, /* 00111100 */
    0x00, /* 00000000 */
 
-   /* 142 0x8e 'é' */
+   /* 142 0x8e '√Ñ' */
    0xc6, /* 11000110 */
    0x38, /* 00111000 */
    0x6c, /* 01101100 */
@@ -1446,7 +1446,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xc6, /* 11000110 */
    0x00, /* 00000000 */
 
-   /* 143 0x8f 'è' */
+   /* 143 0x8f '√Ö' */
    0x38, /* 00111000 */
    0x6c, /* 01101100 */
    0x7c, /* 01111100 */
@@ -1456,7 +1456,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xc6, /* 11000110 */
    0x00, /* 00000000 */
 
-   /* 144 0x90 'ê' */
+   /* 144 0x90 '√â' */
    0x18, /* 00011000 */
    0x30, /* 00110000 */
    0xfe, /* 11111110 */
@@ -1466,7 +1466,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xfe, /* 11111110 */
    0x00, /* 00000000 */
 
-   /* 145 0x91 'ë' */
+   /* 145 0x91 '√¶' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x7e, /* 01111110 */
@@ -1476,7 +1476,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7e, /* 01111110 */
    0x00, /* 00000000 */
 
-   /* 146 0x92 'í' */
+   /* 146 0x92 '√Ü' */
    0x3e, /* 00111110 */
    0x6c, /* 01101100 */
    0xcc, /* 11001100 */
@@ -1486,7 +1486,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xce, /* 11001110 */
    0x00, /* 00000000 */
 
-   /* 147 0x93 'ì' */
+   /* 147 0x93 '√¥' */
    0x7c, /* 01111100 */
    0x82, /* 10000010 */
    0x7c, /* 01111100 */
@@ -1496,7 +1496,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0x00, /* 00000000 */
 
-   /* 148 0x94 'î' */
+   /* 148 0x94 '√∂' */
    0xc6, /* 11000110 */
    0x00, /* 00000000 */
    0x7c, /* 01111100 */
@@ -1506,7 +1506,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0x00, /* 00000000 */
 
-   /* 149 0x95 'ï' */
+   /* 149 0x95 '√≤' */
    0x30, /* 00110000 */
    0x18, /* 00011000 */
    0x7c, /* 01111100 */
@@ -1516,7 +1516,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0x00, /* 00000000 */
 
-   /* 150 0x96 'ñ' */
+   /* 150 0x96 '√ª' */
    0x78, /* 01111000 */
    0x84, /* 10000100 */
    0x00, /* 00000000 */
@@ -1526,7 +1526,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 151 0x97 'ó' */
+   /* 151 0x97 '√π' */
    0x60, /* 01100000 */
    0x30, /* 00110000 */
    0xcc, /* 11001100 */
@@ -1536,7 +1536,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 152 0x98 'ò' */
+   /* 152 0x98 '√ø' */
    0xc6, /* 11000110 */
    0x00, /* 00000000 */
    0xc6, /* 11000110 */
@@ -1546,7 +1546,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x06, /* 00000110 */
    0xfc, /* 11111100 */
 
-   /* 153 0x99 'ô' */
+   /* 153 0x99 '√ñ' */
    0xc6, /* 11000110 */
    0x38, /* 00111000 */
    0x6c, /* 01101100 */
@@ -1556,7 +1556,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x38, /* 00111000 */
    0x00, /* 00000000 */
 
-   /* 154 0x9a 'ö' */
+   /* 154 0x9a '√ú' */
    0xc6, /* 11000110 */
    0x00, /* 00000000 */
    0xc6, /* 11000110 */
@@ -1566,7 +1566,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0x00, /* 00000000 */
 
-   /* 155 0x9b 'õ' */
+   /* 155 0x9b '¬¢' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x7e, /* 01111110 */
@@ -1576,7 +1576,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 156 0x9c 'ú' */
+   /* 156 0x9c '¬£' */
    0x38, /* 00111000 */
    0x6c, /* 01101100 */
    0x64, /* 01100100 */
@@ -1586,7 +1586,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xfc, /* 11111100 */
    0x00, /* 00000000 */
 
-   /* 157 0x9d 'ù' */
+   /* 157 0x9d '¬•' */
    0x66, /* 01100110 */
    0x66, /* 01100110 */
    0x3c, /* 00111100 */
@@ -1596,7 +1596,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 158 0x9e 'û' */
+   /* 158 0x9e '‚Çß' */
    0xf8, /* 11111000 */
    0xcc, /* 11001100 */
    0xcc, /* 11001100 */
@@ -1606,7 +1606,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xc6, /* 11000110 */
    0xc7, /* 11000111 */
 
-   /* 159 0x9f 'ü' */
+   /* 159 0x9f '∆í' */
    0x0e, /* 00001110 */
    0x1b, /* 00011011 */
    0x18, /* 00011000 */
@@ -1616,7 +1616,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x70, /* 01110000 */
    0x00, /* 00000000 */
 
-   /* 160 0xa0 '†' */
+   /* 160 0xa0 '√°' */
    0x18, /* 00011000 */
    0x30, /* 00110000 */
    0x78, /* 01111000 */
@@ -1626,7 +1626,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 161 0xa1 '°' */
+   /* 161 0xa1 '√≠' */
    0x0c, /* 00001100 */
    0x18, /* 00011000 */
    0x00, /* 00000000 */
@@ -1636,7 +1636,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x3c, /* 00111100 */
    0x00, /* 00000000 */
 
-   /* 162 0xa2 '¢' */
+   /* 162 0xa2 '√≥' */
    0x0c, /* 00001100 */
    0x18, /* 00011000 */
    0x7c, /* 01111100 */
@@ -1646,7 +1646,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0x00, /* 00000000 */
 
-   /* 163 0xa3 '£' */
+   /* 163 0xa3 '√∫' */
    0x18, /* 00011000 */
    0x30, /* 00110000 */
    0xcc, /* 11001100 */
@@ -1656,7 +1656,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 164 0xa4 '§' */
+   /* 164 0xa4 '√±' */
    0x76, /* 01110110 */
    0xdc, /* 11011100 */
    0x00, /* 00000000 */
@@ -1666,7 +1666,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x66, /* 01100110 */
    0x00, /* 00000000 */
 
-   /* 165 0xa5 '•' */
+   /* 165 0xa5 '√ë' */
    0x76, /* 01110110 */
    0xdc, /* 11011100 */
    0x00, /* 00000000 */
@@ -1676,7 +1676,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xce, /* 11001110 */
    0x00, /* 00000000 */
 
-   /* 166 0xa6 '¶' */
+   /* 166 0xa6 '¬™' */
    0x3c, /* 00111100 */
    0x6c, /* 01101100 */
    0x6c, /* 01101100 */
@@ -1686,7 +1686,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 167 0xa7 'ß' */
+   /* 167 0xa7 '¬∫' */
    0x38, /* 00111000 */
    0x6c, /* 01101100 */
    0x6c, /* 01101100 */
@@ -1696,7 +1696,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 168 0xa8 '®' */
+   /* 168 0xa8 '¬ø' */
    0x18, /* 00011000 */
    0x00, /* 00000000 */
    0x18, /* 00011000 */
@@ -1706,7 +1706,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x3e, /* 00111110 */
    0x00, /* 00000000 */
 
-   /* 169 0xa9 '©' */
+   /* 169 0xa9 '‚åê' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -1716,7 +1716,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 170 0xaa '™' */
+   /* 170 0xaa '¬¨' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -1726,7 +1726,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 171 0xab '´' */
+   /* 171 0xab '¬Ω' */
    0x63, /* 01100011 */
    0xe6, /* 11100110 */
    0x6c, /* 01101100 */
@@ -1736,7 +1736,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xcc, /* 11001100 */
    0x0f, /* 00001111 */
 
-   /* 172 0xac '¨' */
+   /* 172 0xac '¬º' */
    0x63, /* 01100011 */
    0xe6, /* 11100110 */
    0x6c, /* 01101100 */
@@ -1746,7 +1746,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xdf, /* 11011111 */
    0x06, /* 00000110 */
 
-   /* 173 0xad '≠' */
+   /* 173 0xad '¬°' */
    0x18, /* 00011000 */
    0x00, /* 00000000 */
    0x18, /* 00011000 */
@@ -1756,7 +1756,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x00, /* 00000000 */
 
-   /* 174 0xae 'Æ' */
+   /* 174 0xae '¬´' */
    0x00, /* 00000000 */
    0x33, /* 00110011 */
    0x66, /* 01100110 */
@@ -1766,7 +1766,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 175 0xaf 'Ø' */
+   /* 175 0xaf '¬ª' */
    0x00, /* 00000000 */
    0xcc, /* 11001100 */
    0x66, /* 01100110 */
@@ -1776,7 +1776,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 176 0xb0 '∞' */
+   /* 176 0xb0 '‚ñë' */
    0x22, /* 00100010 */
    0x88, /* 10001000 */
    0x22, /* 00100010 */
@@ -1786,7 +1786,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x22, /* 00100010 */
    0x88, /* 10001000 */
 
-   /* 177 0xb1 '±' */
+   /* 177 0xb1 '‚ñí' */
    0x55, /* 01010101 */
    0xaa, /* 10101010 */
    0x55, /* 01010101 */
@@ -1796,7 +1796,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x55, /* 01010101 */
    0xaa, /* 10101010 */
 
-   /* 178 0xb2 '≤' */
+   /* 178 0xb2 '‚ñì' */
    0x77, /* 01110111 */
    0xdd, /* 11011101 */
    0x77, /* 01110111 */
@@ -1806,7 +1806,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x77, /* 01110111 */
    0xdd, /* 11011101 */
 
-   /* 179 0xb3 '≥' */
+   /* 179 0xb3 '‚îÇ' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
@@ -1816,7 +1816,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 180 0xb4 '¥' */
+   /* 180 0xb4 '‚î§' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
@@ -1826,7 +1826,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 181 0xb5 'µ' */
+   /* 181 0xb5 '‚ï°' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0xf8, /* 11111000 */
@@ -1836,7 +1836,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 182 0xb6 '∂' */
+   /* 182 0xb6 '‚ï¢' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
@@ -1846,7 +1846,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 183 0xb7 '∑' */
+   /* 183 0xb7 '‚ïñ' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -1856,7 +1856,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 184 0xb8 '∏' */
+   /* 184 0xb8 '‚ïï' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0xf8, /* 11111000 */
@@ -1866,7 +1866,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 185 0xb9 'π' */
+   /* 185 0xb9 '‚ï£' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0xf6, /* 11110110 */
@@ -1876,7 +1876,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 186 0xba '∫' */
+   /* 186 0xba '‚ïë' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
@@ -1886,7 +1886,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 187 0xbb 'ª' */
+   /* 187 0xbb '‚ïó' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0xfe, /* 11111110 */
@@ -1896,7 +1896,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 188 0xbc 'º' */
+   /* 188 0xbc '‚ïù' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0xf6, /* 11110110 */
@@ -1906,7 +1906,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 189 0xbd 'Ω' */
+   /* 189 0xbd '‚ïú' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
@@ -1916,7 +1916,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 190 0xbe 'æ' */
+   /* 190 0xbe '‚ïõ' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0xf8, /* 11111000 */
@@ -1926,7 +1926,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 191 0xbf 'ø' */
+   /* 191 0xbf '‚îê' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -1936,7 +1936,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 192 0xc0 '¿' */
+   /* 192 0xc0 '‚îî' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
@@ -1946,7 +1946,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 193 0xc1 '¡' */
+   /* 193 0xc1 '‚î¥' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
@@ -1956,7 +1956,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 194 0xc2 '¬' */
+   /* 194 0xc2 '‚î¨' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -1966,7 +1966,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 195 0xc3 '√' */
+   /* 195 0xc3 '‚îú' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
@@ -1976,7 +1976,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 196 0xc4 'ƒ' */
+   /* 196 0xc4 '‚îÄ' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -1986,7 +1986,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 197 0xc5 '≈' */
+   /* 197 0xc5 '‚îº' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
@@ -1996,7 +1996,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 198 0xc6 '∆' */
+   /* 198 0xc6 '‚ïû' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x1f, /* 00011111 */
@@ -2006,7 +2006,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 199 0xc7 '«' */
+   /* 199 0xc7 '‚ïü' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
@@ -2016,7 +2016,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 200 0xc8 '»' */
+   /* 200 0xc8 '‚ïö' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0x37, /* 00110111 */
@@ -2026,7 +2026,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 201 0xc9 '…' */
+   /* 201 0xc9 '‚ïî' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x3f, /* 00111111 */
@@ -2036,7 +2036,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 202 0xca ' ' */
+   /* 202 0xca '‚ï©' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0xf7, /* 11110111 */
@@ -2046,7 +2046,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 203 0xcb 'À' */
+   /* 203 0xcb '‚ï¶' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0xff, /* 11111111 */
@@ -2056,7 +2056,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 204 0xcc 'Ã' */
+   /* 204 0xcc '‚ï†' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0x37, /* 00110111 */
@@ -2066,7 +2066,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 205 0xcd 'Õ' */
+   /* 205 0xcd '‚ïê' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0xff, /* 11111111 */
@@ -2076,7 +2076,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 206 0xce 'Œ' */
+   /* 206 0xce '‚ï¨' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0xf7, /* 11110111 */
@@ -2086,7 +2086,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 207 0xcf 'œ' */
+   /* 207 0xcf '‚ïß' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0xff, /* 11111111 */
@@ -2096,7 +2096,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 208 0xd0 '–' */
+   /* 208 0xd0 '‚ï®' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
@@ -2106,7 +2106,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 209 0xd1 '—' */
+   /* 209 0xd1 '‚ï§' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0xff, /* 11111111 */
@@ -2116,7 +2116,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 210 0xd2 '“' */
+   /* 210 0xd2 '‚ï•' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -2126,7 +2126,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 211 0xd3 '”' */
+   /* 211 0xd3 '‚ïô' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
@@ -2136,7 +2136,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 212 0xd4 '‘' */
+   /* 212 0xd4 '‚ïò' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x1f, /* 00011111 */
@@ -2146,7 +2146,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 213 0xd5 '’' */
+   /* 213 0xd5 '‚ïí' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x1f, /* 00011111 */
@@ -2156,7 +2156,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 214 0xd6 '÷' */
+   /* 214 0xd6 '‚ïì' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -2166,7 +2166,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 215 0xd7 '◊' */
+   /* 215 0xd7 '‚ï´' */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
@@ -2176,7 +2176,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x36, /* 00110110 */
    0x36, /* 00110110 */
 
-   /* 216 0xd8 'ÿ' */
+   /* 216 0xd8 '‚ï™' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0xff, /* 11111111 */
@@ -2186,7 +2186,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 217 0xd9 'Ÿ' */
+   /* 217 0xd9 '‚îò' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
@@ -2196,7 +2196,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 218 0xda '⁄' */
+   /* 218 0xda '‚îå' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -2206,7 +2206,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 219 0xdb '€' */
+   /* 219 0xdb '‚ñà' */
    0xff, /* 11111111 */
    0xff, /* 11111111 */
    0xff, /* 11111111 */
@@ -2216,7 +2216,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xff, /* 11111111 */
    0xff, /* 11111111 */
 
-   /* 220 0xdc '‹' */
+   /* 220 0xdc '‚ñÑ' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -2226,7 +2226,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xff, /* 11111111 */
    0xff, /* 11111111 */
 
-   /* 221 0xdd '›' */
+   /* 221 0xdd '‚ñå' */
    0xf0, /* 11110000 */
    0xf0, /* 11110000 */
    0xf0, /* 11110000 */
@@ -2236,7 +2236,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xf0, /* 11110000 */
    0xf0, /* 11110000 */
 
-   /* 222 0xde 'ﬁ' */
+   /* 222 0xde '‚ñê' */
    0x0f, /* 00001111 */
    0x0f, /* 00001111 */
    0x0f, /* 00001111 */
@@ -2246,7 +2246,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x0f, /* 00001111 */
    0x0f, /* 00001111 */
 
-   /* 223 0xdf 'ﬂ' */
+   /* 223 0xdf '‚ñÄ' */
    0xff, /* 11111111 */
    0xff, /* 11111111 */
    0xff, /* 11111111 */
@@ -2256,7 +2256,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 224 0xe0 '‡' */
+   /* 224 0xe0 'Œ±' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x76, /* 01110110 */
@@ -2266,7 +2266,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x76, /* 01110110 */
    0x00, /* 00000000 */
 
-   /* 225 0xe1 '·' */
+   /* 225 0xe1 '√ü' */
    0x78, /* 01111000 */
    0xcc, /* 11001100 */
    0xcc, /* 11001100 */
@@ -2276,7 +2276,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xcc, /* 11001100 */
    0x00, /* 00000000 */
 
-   /* 226 0xe2 '‚' */
+   /* 226 0xe2 'Œì' */
    0xfe, /* 11111110 */
    0xc6, /* 11000110 */
    0xc0, /* 11000000 */
@@ -2286,7 +2286,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xc0, /* 11000000 */
    0x00, /* 00000000 */
 
-   /* 227 0xe3 '„' */
+   /* 227 0xe3 'œÄ' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0xfe, /* 11111110 */
@@ -2296,7 +2296,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x6c, /* 01101100 */
    0x00, /* 00000000 */
 
-   /* 228 0xe4 '‰' */
+   /* 228 0xe4 'Œ£' */
    0xfe, /* 11111110 */
    0xc6, /* 11000110 */
    0x60, /* 01100000 */
@@ -2306,7 +2306,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xfe, /* 11111110 */
    0x00, /* 00000000 */
 
-   /* 229 0xe5 'Â' */
+   /* 229 0xe5 'œÉ' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x7e, /* 01111110 */
@@ -2316,7 +2316,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x70, /* 01110000 */
    0x00, /* 00000000 */
 
-   /* 230 0xe6 'Ê' */
+   /* 230 0xe6 '¬µ' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x66, /* 01100110 */
@@ -2326,7 +2326,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7c, /* 01111100 */
    0xc0, /* 11000000 */
 
-   /* 231 0xe7 'Á' */
+   /* 231 0xe7 'œÑ' */
    0x00, /* 00000000 */
    0x76, /* 01110110 */
    0xdc, /* 11011100 */
@@ -2336,7 +2336,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x00, /* 00000000 */
 
-   /* 232 0xe8 'Ë' */
+   /* 232 0xe8 'Œ¶' */
    0x7e, /* 01111110 */
    0x18, /* 00011000 */
    0x3c, /* 00111100 */
@@ -2346,7 +2346,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x7e, /* 01111110 */
 
-   /* 233 0xe9 'È' */
+   /* 233 0xe9 'Œò' */
    0x38, /* 00111000 */
    0x6c, /* 01101100 */
    0xc6, /* 11000110 */
@@ -2356,7 +2356,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x38, /* 00111000 */
    0x00, /* 00000000 */
 
-   /* 234 0xea 'Í' */
+   /* 234 0xea 'Œ©' */
    0x38, /* 00111000 */
    0x6c, /* 01101100 */
    0xc6, /* 11000110 */
@@ -2366,7 +2366,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xee, /* 11101110 */
    0x00, /* 00000000 */
 
-   /* 235 0xeb 'Î' */
+   /* 235 0xeb 'Œ¥' */
    0x0e, /* 00001110 */
    0x18, /* 00011000 */
    0x0c, /* 00001100 */
@@ -2376,7 +2376,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x3c, /* 00111100 */
    0x00, /* 00000000 */
 
-   /* 236 0xec 'Ï' */
+   /* 236 0xec '‚àû' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x7e, /* 01111110 */
@@ -2386,7 +2386,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 237 0xed 'Ì' */
+   /* 237 0xed 'œÜ' */
    0x06, /* 00000110 */
    0x0c, /* 00001100 */
    0x7e, /* 01111110 */
@@ -2396,7 +2396,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x60, /* 01100000 */
    0xc0, /* 11000000 */
 
-   /* 238 0xee 'Ó' */
+   /* 238 0xee 'Œµ' */
    0x1e, /* 00011110 */
    0x30, /* 00110000 */
    0x60, /* 01100000 */
@@ -2406,7 +2406,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x1e, /* 00011110 */
    0x00, /* 00000000 */
 
-   /* 239 0xef 'Ô' */
+   /* 239 0xef '‚à©' */
    0x00, /* 00000000 */
    0x7c, /* 01111100 */
    0xc6, /* 11000110 */
@@ -2416,7 +2416,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xc6, /* 11000110 */
    0x00, /* 00000000 */
 
-   /* 240 0xf0 '' */
+   /* 240 0xf0 '‚â°' */
    0x00, /* 00000000 */
    0xfe, /* 11111110 */
    0x00, /* 00000000 */
@@ -2426,7 +2426,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 241 0xf1 'Ò' */
+   /* 241 0xf1 '¬±' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x7e, /* 01111110 */
@@ -2436,7 +2436,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7e, /* 01111110 */
    0x00, /* 00000000 */
 
-   /* 242 0xf2 'Ú' */
+   /* 242 0xf2 '‚â•' */
    0x30, /* 00110000 */
    0x18, /* 00011000 */
    0x0c, /* 00001100 */
@@ -2446,7 +2446,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7e, /* 01111110 */
    0x00, /* 00000000 */
 
-   /* 243 0xf3 'Û' */
+   /* 243 0xf3 '‚â§' */
    0x0c, /* 00001100 */
    0x18, /* 00011000 */
    0x30, /* 00110000 */
@@ -2456,7 +2456,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x7e, /* 01111110 */
    0x00, /* 00000000 */
 
-   /* 244 0xf4 'Ù' */
+   /* 244 0xf4 '‚å†' */
    0x0e, /* 00001110 */
    0x1b, /* 00011011 */
    0x1b, /* 00011011 */
@@ -2466,7 +2466,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x18, /* 00011000 */
    0x18, /* 00011000 */
 
-   /* 245 0xf5 'ı' */
+   /* 245 0xf5 '‚å°' */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
    0x18, /* 00011000 */
@@ -2476,7 +2476,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0xd8, /* 11011000 */
    0x70, /* 01110000 */
 
-   /* 246 0xf6 'ˆ' */
+   /* 246 0xf6 '√∑' */
    0x00, /* 00000000 */
    0x18, /* 00011000 */
    0x00, /* 00000000 */
@@ -2486,7 +2486,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 247 0xf7 '˜' */
+   /* 247 0xf7 '‚âà' */
    0x00, /* 00000000 */
    0x76, /* 01110110 */
    0xdc, /* 11011100 */
@@ -2496,7 +2496,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 248 0xf8 '¯' */
+   /* 248 0xf8 '¬∞' */
    0x38, /* 00111000 */
    0x6c, /* 01101100 */
    0x6c, /* 01101100 */
@@ -2506,7 +2506,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 249 0xf9 '˘' */
+   /* 249 0xf9 '¬∑' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -2516,7 +2516,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 250 0xfa '˙' */
+   /* 250 0xfa '‚Ä¢' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
@@ -2526,7 +2526,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 251 0xfb '˚' */
+   /* 251 0xfb '‚àö' */
    0x0f, /* 00001111 */
    0x0c, /* 00001100 */
    0x0c, /* 00001100 */
@@ -2536,7 +2536,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x3c, /* 00111100 */
    0x1c, /* 00011100 */
 
-   /* 252 0xfc '¸' */
+   /* 252 0xfc '‚Åø' */
    0x6c, /* 01101100 */
    0x36, /* 00110110 */
    0x36, /* 00110110 */
@@ -2546,7 +2546,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 253 0xfd '˝' */
+   /* 253 0xfd '¬≤' */
    0x78, /* 01111000 */
    0x0c, /* 00001100 */
    0x18, /* 00011000 */
@@ -2556,7 +2556,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 254 0xfe '˛' */
+   /* 254 0xfe '‚ñ†' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x3c, /* 00111100 */
@@ -2566,7 +2566,7 @@ static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
    0x00, /* 00000000 */
    0x00, /* 00000000 */
 
-   /* 255 0xff 'ˇ' */
+   /* 255 0xff '¬†' */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
    0x00, /* 00000000 */
-- 
2.18.0

