Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490082-1521484199-2-14500474572946821973
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
    t=1521484198; b=ai9OYCwKPxZLRCMuR7AiaYaSWoYphExOeMi9/fbnzkobwCp
    HYreqTqNfJ+b+xxoQwrXI/BCP7pSR+5qYgf/HuEU0r9D//sUgSK2gYhbdACPXY2v
    N2QS3OrePuHLDv22lhpXbtY5vnv7H7t7Pse/eI0G1vBmZ92CEacB0Og9uP9KYUvi
    EbNGsOPrNt0kYhI3FTMD4FEvtNW3PuHbjesjh+xB/TVt1imjgOVoHJtvyaC02kM5
    7xWt7c8D5jrXY4XfFYlL1Qh5U/6rKxR9DSCO6Kz+HP0BIKxa2eDNX+W7huQyxsxf
    W/O8cZGpjIuLlvRA7a1ufRYMyiO2bVANV9xNmvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484198; bh=yrIEWeIfOYmwxVX0dJ5NlQwcSZ
    yAtTRqO1IOnYLVHEk=; b=nInKQzpg2DoX6b2hWvJlux2ne1/2vStaug8QYLjrpl
    cvgUXzgPfJ7+cPLuGois0u+dicbXNxnuV7FyFJCbc7Diu7NIn0qPsehUGdL4pNaO
    rca5Ksog7TIQSo9Mgu7EOAp23Hxf0cJYbs4trjhhgn6tYqsSYgFd/U4FXo11/wzI
    P0bdIDXeUlEGTH/em4BLN862ZHEIqJImPnOnC+IdsSAf1kms27+hGfRLW9hPbzXh
    tbcLmBG/p3H3wIRI4k/vofUuajA2pXt0IY+agUmMdCwFtcU8cun7lzwoHzpxwFGc
    b8iZly6Mz3htGkWWZJgaonn0Ktce+Ynpap4+tiojk2Qw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepiedviedtnecuvehluhhsthgvrhfuihiivgepvdef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepiedviedtnecuvehluhhsthgvrhfuihiivgepvdef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031890AbeCSS3y (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:29:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967819AbeCSS3w (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:29:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Brian Gerst <brgerst@gmail.com>,
        Chen Yucong <slaoub@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        Jiri Slaby <jslaby@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, ricardo.neri@intel.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 05/41] selftests/x86: Add tests for the STR and SLDT instructions
Date: Mon, 19 Mar 2018 19:08:05 +0100
Message-Id: <20180319180732.538855851@linuxfoundation.org>
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

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

commit a9e017d5619eb371460c8e516f4684def62bef3a upstream.

The STR and SLDT instructions are not valid when running on virtual-8086
mode and generate an invalid operand exception. These two instructions are
protected by the Intel User-Mode Instruction Prevention (UMIP) security
feature. In protected mode, if UMIP is enabled, these instructions generate
a general protection fault if called from CPL > 0. Linux traps the general
protection fault and emulates the instructions sgdt, sidt and smsw; but not
str and sldt.

These tests are added to verify that the emulation code does not emulate
these two instructions but the expected invalid operand exception is
seen.

Tests fallback to exit with INT3 in case emulation does happen.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Chen Yucong <slaoub@gmail.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi V. Shankar <ravi.v.shankar@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: ricardo.neri@intel.com
Link: http://lkml.kernel.org/r/1509935277-22138-13-git-send-email-ricardo.neri-calderon@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/entry_from_vm86.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -111,6 +111,11 @@ asm (
 	"smsw %ax\n\t"
 	"mov %ax, (2080)\n\t"
 	"int3\n\t"
+	"vmcode_umip_str:\n\t"
+	"str %eax\n\t"
+	"vmcode_umip_sldt:\n\t"
+	"sldt %eax\n\t"
+	"int3\n\t"
 	".size vmcode, . - vmcode\n\t"
 	"end_vmcode:\n\t"
 	".code32\n\t"
@@ -119,7 +124,8 @@ asm (
 
 extern unsigned char vmcode[], end_vmcode[];
 extern unsigned char vmcode_bound[], vmcode_sysenter[], vmcode_syscall[],
-	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_umip[];
+	vmcode_sti[], vmcode_int3[], vmcode_int80[], vmcode_umip[],
+	vmcode_umip_str[], vmcode_umip_sldt[];
 
 /* Returns false if the test was skipped. */
 static bool do_test(struct vm86plus_struct *v86, unsigned long eip,
@@ -226,6 +232,16 @@ void do_umip_tests(struct vm86plus_struc
 		printf("[FAIL]\tAll the results of SIDT should be the same.\n");
 	else
 		printf("[PASS]\tAll the results from SIDT are identical.\n");
+
+	sethandler(SIGILL, sighandler, 0);
+	do_test(vm86, vmcode_umip_str - vmcode, VM86_SIGNAL, 0,
+		"STR instruction");
+	clearhandler(SIGILL);
+
+	sethandler(SIGILL, sighandler, 0);
+	do_test(vm86, vmcode_umip_sldt - vmcode, VM86_SIGNAL, 0,
+		"SLDT instruction");
+	clearhandler(SIGILL);
 }
 
 int main(void)
