Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223491-1524186501-2-7915148246454568100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186500; b=mty22VUHvK1IrW5agZvlUStccub+OVqlQGs00pINgAvqDFhPEj
    C5OzhvF2xu1JV50IeFwQ86s3PDAc8qC+2hRTKGCCyvNrKzJTSjYCiD6R+7mTpV6R
    KQl+TSrYj9MVAvWKUfVyaGk55FZbcQDqwN7W+TVt7hO8rKU7hzFIxDPF0TEWWdyV
    Ac5INDJvFvuc72cB26PNjbxZRsMk1U5cw4S2kNUmua3SBkmjVNPxYrsDVJ+3XhcB
    O7h1zk1SQv1tiGu98Rg4Xc9WRzJeuETRi0Iq/Lbklc7SW7D/LYHFr84Q7z4wzF2t
    IHlMwa5pjFnRsTL78qkRHortPmSCUoXRAxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1524186500; bh=k1Zs
    88YQOQnk7MvBQJVnoAsHf7kwQ6UZ1BzO0sUrOQI=; b=sB5plDYJny8AlnPujANX
    L1nPbt18GybL0jeR07HoxXabCG/dKzEdY8/DL1Q1mJDg1mnk59K4Q4yvIZtyQyE/
    Jf+/nuQPsoD2gLDyeqthnQlaU4hQcW1ZmcSP6v0Vd6h4w0FLAatkfMHwqhF5ZRfW
    XFnyGBRLvXIG6OXezWbg2EjIlOIeR+8367hUgQSpyuQcXNQ14htM5fGxaX41VpvI
    uOPUXVdBNKCU6qwMjydOiUbSKb58I4Ff+t/bgltzp7DK7NMyBsggKwy8g+QaO2Xd
    B7/r8wcwsPuDRH3UG8KuT/4Ue/3chL7x5GkMBEBL2BdTISkDMmSy69pcSfCX8kAB
    eA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBuKALymNhNLSeR3p2yF4bwc1EAEptDgU5rPuZqT9rBeofy8geQO0K5e+crCyq4BflZthjybwWqj+okpUg/5ZmW4StKDE6BfScPpLFQqVRS2HU4Y356k
    TSmytMv3Hcu8qfJ8aRlzQf6QTIaUj6iEtB/+00T/M1wkL/SZWbXO79JQh7YNpzP7zsEpYuddTvy0CL0n0+fmeouPL7igRRmlMwe1Opc6edO5jJth6XdySbLf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8
    a=VwQbUJbxAAAA:8 a=Qrv8zfc0eTLMhErBtQ4A:9 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753992AbeDTBHa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:07:30 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50138 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbeDTBH2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:07:28 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu, 19 Apr 2018 20:04:00 -0500
Message-Id: <20180420010408.24438-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <878t9ilmhv.fsf@xmission.com>
References: <878t9ilmhv.fsf@xmission.com>
X-XM-SPF: eid=1f9KWN-00014u-Py;;;mid=<20180420010408.24438-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9AhTvtDm+V2C7GuFg/qwSp4Qi6n8NInQ=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: **
X-Remote-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4791]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: **;linux-arch@vger.kernel.org
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 175 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (1.5%), b_tie_ro: 1.82 (1.0%), parse: 0.67 (0.4%),
        extract_message_metadata: 9 (5.4%), get_uri_detail_list: 1.23 (0.7%),
        tests_pri_-1000: 5 (3.0%), tests_pri_-950: 1.16 (0.7%), tests_pri_-900: 1.03
        (0.6%), tests_pri_-400: 17 (9.5%), check_bayes: 16 (9.0%), b_tokenize: 6
        (3.2%), b_tok_get_all: 4.9 (2.8%), b_comp_prob: 1.34 (0.8%), b_tok_touch_all:
        2.3 (1.3%), b_finish: 0.54 (0.3%), tests_pri_0: 132 (75.6%),
        check_dkim_signature: 0.44 (0.2%), check_dkim_adsp: 2.4 (1.4%),
        tests_pri_500: 3.6 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 09/17] signal: Remove SEGV_BNDERR ifdefs
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After the last round of cleanups to siginfo.h SEGV_BNDERR is defined
on all architectures so testing to see if it is defined is unnecessary.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index fc82d2c0918f..a6d55a6e9915 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1570,7 +1570,6 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
 EXPORT_SYMBOL(send_sig_mceerr);
 #endif
 
-#ifdef SEGV_BNDERR
 int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 {
 	struct siginfo info;
@@ -1584,7 +1583,6 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 	info.si_upper = upper;
 	return force_sig_info(info.si_signo, &info, current);
 }
-#endif
 
 #ifdef SEGV_PKUERR
 int force_sig_pkuerr(void __user *addr, u32 pkey)
@@ -2890,13 +2888,11 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
 		if ((from->si_signo == SIGBUS) && (from->si_code == BUS_MCEERR_AO))
 			new.si_addr_lsb = from->si_addr_lsb;
 #endif
-#ifdef SEGV_BNDERR
 		if ((from->si_signo == SIGSEGV) &&
 		    (from->si_code == SEGV_BNDERR)) {
 			new.si_lower = ptr_to_compat(from->si_lower);
 			new.si_upper = ptr_to_compat(from->si_upper);
 		}
-#endif
 #ifdef SEGV_PKUERR
 		if ((from->si_signo == SIGSEGV) &&
 		    (from->si_code == SEGV_PKUERR))
@@ -2976,12 +2972,10 @@ int copy_siginfo_from_user32(struct siginfo *to,
 		if ((from.si_signo == SIGBUS) && (from.si_code == BUS_MCEERR_AO))
 			to->si_addr_lsb = from.si_addr_lsb;
 #endif
-#ifdef SEGV_BNDERR
 		if ((from.si_signo == SIGSEGV) && (from.si_code == SEGV_BNDERR)) {
 			to->si_lower = compat_ptr(from.si_lower);
 			to->si_upper = compat_ptr(from.si_upper);
 		}
-#endif
 #ifdef SEGV_PKUERR
 		if ((from.si_signo == SIGSEGV) && (from.si_code == SEGV_PKUERR))
 			to->si_pkey = from.si_pkey;
-- 
2.14.1

