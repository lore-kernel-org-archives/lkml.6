Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeBHOkX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:40:23 -0500
Received: from mout.web.de ([212.227.15.14]:48049 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752208AbeBHOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:40:20 -0500
Subject: [PATCH 3/3] drm/gma500: Delete an unnecessary return statement in
 oaktrail_crtc_hdmi_dpms()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <079c31b2-a2e6-cf42-cecb-e1e10dd241f6@users.sourceforge.net>
Message-ID: <9871ef86-0cd6-aab8-1252-53bc08fc79af@users.sourceforge.net>
Date: Thu, 8 Feb 2018 15:40:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <079c31b2-a2e6-cf42-cecb-e1e10dd241f6@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Ibl/1P3Ude+R8+TEt6nxAqPEteQaRDpiJ2eqasNE+H7ftvmQ0xJ
 cKPQJ1MlLkTrw4+79f02UX4FtZWWduQNOTP9VyMcoP/j8CwFxKHz5dvEvsEmHQD8T4NBQv1
 owBsIuNZW2tIRspf+YYtGpbcBwSe34VlbH4ZMGlo3xbTXre4fBykcmInELqkd2am1mqNnPf
 vb8Gl7dmXayuUtWA3NyzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5sDfNeVJ2Jk=:hDH08bHv1ZcHwL0MpewAUY
 wb0VrdZzI/Nu5GuPZiZ4CFiit3iecAoVv6PiWGdz4VrHrVmXUKoe3qafJGY2wHNIPhQCnMa/Q
 f1+lBFWlWHgp9x+YbuxuqtlrR+s+mv5Mc5wvYGWccxCdCdnPlrYCcel2KlGyKvrxE1ecIwVzt
 U35lENPAcJXbYu/4xewurP8TkGRX9bih70D2K+6uCoptWV5j6XbH6Tj26JYR7jVs7hKicxIYd
 iDJ5aGE5a4DX5p1Hwg8fFHGXJm8CsJoSGS/Fig4izr2VICflsFsRRNgC8IL4dK5Syqesce9rh
 1YiVIrIIgFCE3fm/3poQCKEv7Kg8JqrvPglyWtp5khimRomZhhiuNREem5CjCxbMllOAT63Yg
 hrbD6OsAn5EqUwagMlevltp87PQL+PxdQEgCcEiZG4J2fHkT4HLCdITbG9WPmjcbmD5IoEhKH
 vcrCc8FtHX9f3fiVNTpTa8q1WWISN3f6t9h7r8Dm529lFvfKja3wNfjmF0jTBAAqDqg3h+2u6
 f6aszuqcnJr8mO7qAx3BPWXZbOWgc6iMrKsuuwQdMvjxGKYXnDEe6u39dK7RaV1eNUpjyM2Ls
 DxDD99aULheux9FSTAHcolqDUFeDQk/aHXU8xNig38xBOsH2lXKDxEPNFzeOBO8NVZa98U4Pm
 8Ohig28o97h5cvLb7Lyymso4+1FPbwgm7ACjGUJ6twSD7kwZ1sdXwUdzh2RjkErf0mMGcHIsP
 AA/lr/exs59wwkNPfmYA7S2t949Y9b8ChgOg1Zza4bYpTk4SOvTHOWUO4685XHRdfS68N4lbC
 F+bYHImwBsHWSZJVdOeEsxEKXMkwlUzpsieHVhdCmqmUNZRFpk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 15:17:48 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index dbc58e5130bb..24c7c6edfca5 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -484,8 +484,6 @@ void oaktrail_crtc_hdmi_dpms(struct drm_crtc *crtc, int mode)
 
 	/* LNC Chicken Bits - Squawk! */
 	REG_WRITE(0x70400, 0x4000);
-
-	return;
 }
 
 static void oaktrail_hdmi_dpms(struct drm_encoder *encoder, int mode)
-- 
2.16.1
