Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484195-2-15763444011895645474
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
    t=1521484194; b=FaxJYAqFiDbWlMWxjOjYm5m+Xt2HiIjTqLjaBlWbqHyjyPJ
    LKeiFN7SJps8HwGEfsvdyxZFdDxt2TbtAarFSqCjLXUA6aK2wuYjddFraUIGrilG
    X3C8VNRwDNgTQO7LYcVlrutVhN/0YdadKmEH1KoZAZzuc48DgrBM/b26bajV1zmH
    rj9NUhyNcq6PNzAfAH1RNWjT471Fo7J/KxHgEd8ZcMYfjV51kQvCpWyPxGsHSdcj
    i/+4lrSNmSWqcbpW8F2CpPUSI8unChLBT6gPXXeH5XspLUN34X/EhVPOZ3wCBS8E
    8P8ZBSBII9sz+K/su2sKJeNpmpW0gjA09vZ7kLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484194; bh=kDxqEYrGHnwGPPwUBBkJedebHB
    IPio8US+5yDKuATUg=; b=s0Tb9C3WbZi42Dz0j8lKwXqcGAga7/gDc5/NWR6xLG
    76blUwKFi3eH/2dXoW0aQxiMK/Wm7W+fRusDk+WAFt46tRxUg3kZvWLEUHGaGdXU
    EMTYgDMtXb2Zq9XU64a7uaQdLOQGZfoZRj6PDj7gwpUs4mBZ2wuWRyJWS4saGIZ+
    U/brL5F30L/bTOxo05kQ40hUb52bvSDjym2lMq2eg4GSjtxdmE8Rdk2fRw3EdcuH
    z0tUEcQySemIw3LkxaxGM7YIK9GKLHvG3Eb2ei02tA+DyzksCCQsR34/MUC4sL6E
    wB8Hpr00SWOTcKNuULfNJMI3lqrHUTxRG3uMqkarwR+w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeduleefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeduleefnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031885AbeCSS3u (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:29:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031874AbeCSS3r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:29:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stas Sergeev <stsp@list.ru>,
        Thomas Gleixner <tglx@linutronix.de>, bartoldeman@gmail.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 03/41] selftests/x86/entry_from_vm86: Exit with 1 if we fail
Date: Mon, 19 Mar 2018 19:08:03 +0100
Message-Id: <20180319180732.419900100@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 327d53d005ca47b10eae940616ed11c569f75a9b upstream.

Fix a logic error that caused the test to exit with 0 even if test
cases failed.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stas Sergeev <stsp@list.ru>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bartoldeman@gmail.com
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/b1cc37144038958a469c8f70a5f47a6a5638636a.1521003603.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/entry_from_vm86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -231,7 +231,7 @@ int main(void)
 	clearhandler(SIGSEGV);
 
 	/* Make sure nothing explodes if we fork. */
-	if (fork() > 0)
+	if (fork() == 0)
 		return 0;
 
 	return (nerrs == 0 ? 0 : 1);
