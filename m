Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521483117-2-14676906171252921611
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483116; b=NRZjaCmGdcTQvGVTUO1kRpNbzVO3VXMKbT98rD0NbtSXJbw
    yuor/Jl7xvxMh9JjiyroV+blmhNVnXq7/D3a90hmh75MOKInl08mS3c1m5dyD1w2
    SnH/uLH3kjp13X4kTGGs1QIZfxZMQfKme92IYzSJCkIGYBVLVGVG66TUsLd/IVcK
    nDk1/O2eddAP9kpWz3RaSiCD2Neh4fqzCyFeERymS6krO5a1GVjyHjvTJ+cfs252
    0oA/T+tDrBBVjyarJcy2Wl5uvdJR60eL1kkwiZnTDY/8p5l0HpNOZsuge8TYgHEZ
    jJi+hQMSVJ1G/8AhDtM4lHV0Fdm/ZcphdlG5I5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483116; bh=UQtZvtA9wYAXBXXyZEizt8S95T
    0MJIex4+EWiRd2BEE=; b=heKify4v6lSOLGFUwk2O3W/JdeVHHjy4H17XcDGkEJ
    VaXyONclhSUJxBgsR5XmuGuzPFJQnywBU+DEjPqJWzw6KVwV/gW/45/jPC9fndCV
    wlhLZ9zvq8W8rsl6/GQPF9YarXU+LfHWu0WVA8Bnuktr14o6ZPC67Wd5OAnAi640
    FdbewE9djxfHbmKKTK/BJIFQtOa6nt5MTXsvUarzMc5rfjQKi+N7potFQWDhypfg
    wdXla4DtisO/TYm1RXFU4K2O2D07AEZ0zRN++XxQJ65FGa3650Ah/kb0gm0Tn+Ah
    ZaFSJpLf8lKsphDQJxjXxmAgxcBQCgCotU+XR+WJfySw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdejjeenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935213AbeCSSLX (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:11:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968772AbeCSSLU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:11:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 60/68] ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
Date: Mon, 19 Mar 2018 19:06:38 +0100
Message-Id: <20180319171836.304413263@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 01c0b4265cc16bc1f43f475c5944c55c10d5768f upstream.

snd_pcm_oss_get_formats() has an obvious use-after-free around
snd_mask_test() calls, as spotted by syzbot.  The passed format_mask
argument is a pointer to the hw_params object that is freed before the
loop.  What a surprise that it has been present since the original
code of decades ago...

Reported-by: syzbot+4090700a4f13fccaf648@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1815,10 +1815,9 @@ static int snd_pcm_oss_get_formats(struc
 		return -ENOMEM;
 	_snd_pcm_hw_params_any(params);
 	err = snd_pcm_hw_refine(substream, params);
-	format_mask = *hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT); 
-	kfree(params);
 	if (err < 0)
-		return err;
+		goto error;
+	format_mask = *hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	for (fmt = 0; fmt < 32; ++fmt) {
 		if (snd_mask_test(&format_mask, fmt)) {
 			int f = snd_pcm_oss_format_to(fmt);
@@ -1826,7 +1825,10 @@ static int snd_pcm_oss_get_formats(struc
 				formats |= f;
 		}
 	}
-	return formats;
+
+ error:
+	kfree(params);
+	return err < 0 ? err : formats;
 }
 
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
