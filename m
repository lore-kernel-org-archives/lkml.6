Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521483433-2-2888596477852935068
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
    t=1521483431; b=sE1t/Lg9PAGMYSSwWK76L7ZhT4IHCEVcxhgMq5VpELXNrIp
    GAdJ7APqorP6beakYlPi6/d/bMcZRu477yJjI5WknBRY9H3NJkkvhqoCbMBHEgnl
    ydvlMO/4o7+RqC24v7W91cg3Avy3roY+3NPPlPa0XNFA/yfAUl5SHOdOhi5D6yKz
    OfPG2g074Ug+W3XYCgo0ghlTKHJU2JKL0egQ1FjH7DUkSJ74+L7IqNUVs9LQwocg
    DAF/elSVYxr/NzE/pPfBtVaa0bK8iBRC445fGc44VWurf3R+i2hITxg0H5sUDUCl
    Pv/7qfaNdrGQ4RBE7VOXfrIZVDxIkUFZlSGOxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483431; bh=FIJueuJT62GnrPQVgh7dR3jn59
    muFWljcR5k3/WCy1k=; b=BMYeLZTY+ITrV1UjkZo7v9pnHklvp4Boo7Mv2rOK6U
    ZiTcbcG1EcQPQb03xODnct7t0jdd1cFYwVtComjIedMnhubGeFzptk3mj+iNcpNu
    vblK/eTLB7ETWuDsqLogPCUU0vSZVPdtX0ohuXy05nXFhk8Ji32NC1msL6Q1m284
    qa2kXMzBTEOkdk7bloCcaUGPnUtK32TNigu6l7EjUxM2SE5gR9Q7l5E4tzD9ORuR
    5qDWw7LroJvYgG8ZMcfE2jLvz9jFxWYnBcCYi9YFnXpRQ7knkNczJ4HiDoXLH5h6
    R04E1vy+i/k86IxJmJ7RG8ualKcGiP5vzuCXzZu23aVA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeffeejieenucevlhhushhtvghrufhiiigvpeegle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeffeejieenucevlhhushhtvghrufhiiigvpeegle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968969AbeCSSRF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:17:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45400 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968940AbeCSSRD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:17:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 119/134] ALSA: seq: Clear client entry before deleting else at closing
Date: Mon, 19 Mar 2018 19:06:42 +0100
Message-Id: <20180319171906.442618866@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit a2ff19f7b70118ced291a28d5313469914de451b upstream.

When releasing a client, we need to clear the clienttab[] entry at
first, then call snd_seq_queue_client_leave().  Otherwise, the
in-flight cell in the queue might be picked up by the timer interrupt
via snd_seq_check_queue() before calling snd_seq_queue_client_leave(),
and it's delivered to another queue while the client is clearing
queues.  This may eventually result in an uncleared cell remaining in
a queue, and the later snd_seq_pool_delete() may need to wait for a
long time until the event gets really processed.

By moving the clienttab[] clearance at the beginning of release, any
event delivery of a cell belonging to this client will fail at a later
point, since snd_seq_client_ptr() returns NULL.  Thus the cell that
was picked up by the timer interrupt will be returned immediately
without further delivery, and the long stall of snd_seq_delete_pool()
can be avoided, too.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_clientmgr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -270,12 +270,12 @@ static int seq_free_client1(struct snd_s
 
 	if (!client)
 		return 0;
-	snd_seq_delete_all_ports(client);
-	snd_seq_queue_client_leave(client->number);
 	spin_lock_irqsave(&clients_lock, flags);
 	clienttablock[client->number] = 1;
 	clienttab[client->number] = NULL;
 	spin_unlock_irqrestore(&clients_lock, flags);
+	snd_seq_delete_all_ports(client);
+	snd_seq_queue_client_leave(client->number);
 	snd_use_lock_sync(&client->use_lock);
 	snd_seq_queue_client_termination(client->number);
 	if (client->pool)
