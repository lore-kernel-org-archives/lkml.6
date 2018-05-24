Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163539-2-13494176055884107290
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163537; b=GpQ8A1c5kri/oBnI44pLAhCt8thnQbiq4X5IvOBejzvfMJfSKF
    LufMJl43GeBlTVxk7GOwq7ti6mqsaHldQuk2njwG38jwN96UK8i3PjPFsBuJSfD0
    4dU9LiAOnzcS+73Jb7WMUEsmi9uh/xYZdHq2ENbkO7gIuvhB8310Mr+MkGkzCFFR
    Dza0mwfk982c7BMbQ6xqRE7XBPc7Yi4X6+9FEsUFlR57W74oce+3hRip66/M/6g5
    wdLlkbz30wW2KLGIoxVIkyUpgiK+p0qDYYv8bFMfDOmHJRAUmCHllagWlJjTt11J
    /J6k2PXwtADeMHhxoY/LySRidnoua0jIIjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163537; bh=UNoKujPongjZWUsteUjKl3CVx58WMf
    iAM7Jc821e2Ek=; b=QvNePHWnRED4PZQjAhHGIrW1E9+UbEmmi5Z3NE80qoX993
    Zz5SPfQCkfmhb80ZouCzCVpSF5FoflxMLpvAJcJh9P6AF9MWO0cENdaNBiklX6k8
    GInVB0cm0mYHg36bloRPA71/JCL1+a53Jc2urWJQZ1Ougq5t+d6iHqhndLTeYy56
    bC0Lxg9l9uOlIzUt9i5iSqWL9EynqOm/recOjzFsCBQ5NINrWs3MsOwM+zaSWcuF
    pQjJWS9CTIycyKgpm4A4JxbYX9yrKEOAJPI5jJcrpcTvM/tuanCFaaiAx37vP2jK
    8YEdxX4z4aVCZG6CQrCVLxNDfmseEHpdSOpV9gsQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=sS5/pXtH x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=sS5/pXtH x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB26GgpGYkmcF0n4o7Z7aaXzRpk8pDa4trLcXOhBPAc9h/ftFm5SmojdJn36plRULm0ZbfHnI9gdn2sAwoGeCaCqYo4iWwO8cMhtbR5EyTTuuXXICWFJ
    WYQDC9qPwFS0CZGHIu3qWA3e3xeDxpqDArO2NFlooJC9Lq0cLcg2RusN4nsAQSfhD0CJBZwHJEHXN5lwLNMZlsduRYRwf4OUaoPh7MOmcv6Hb9B8SxRhiWso
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=J2zoVyZDAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=ZwEik9AnzkoCkD7mK00A:9
    a=QEXdDO2ut3YA:10 a=DvW0qZC7_2Hvvf243_-1:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966619AbeEXMFU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966623AbeEXJoS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Federico Cuello <fedux@fedux.com.ar>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 38/92] ALSA: usb: mixer: volume quirk for CM102-A+/102S+
Date: Thu, 24 May 2018 11:38:15 +0200
Message-Id: <20180524093202.638183551@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Federico Cuello <fedux@fedux.com.ar>

commit 21493316a3c4598f308d5a9fa31cc74639c4caff upstream.

Currently it's not possible to set volume lower than 26% (it just mutes).

Also fixes this warning:

  Warning! Unlikely big volume range (=9472), cval->res is probably wrong.
  [13] FU [PCM Playback Volume] ch = 2, val = -9473/-1/1

, and volume works fine for full range.

Signed-off-by: Federico Cuello <fedux@fedux.com.ar>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -904,6 +904,14 @@ static void volume_control_quirks(struct
 		}
 		break;
 
+	case USB_ID(0x0d8c, 0x0103):
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				 "set volume quirk for CM102-A+/102S+\n");
+			cval->min = -256;
+		}
+		break;
+
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
