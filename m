Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937867-1524672572-2-7135743677780002621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524672572; b=KqHLaZYp97N9tRwtFg3sv6RTw+XH58oeOIcC+mvNi2E7Dmt1X0
    e7IDH/Yc0+hbquQJbRp6mL0WRVCIuy9oS5516I95CGyAf91ecbMLxLNZvzRKkRoI
    LCxRwhYgBDofgYRhEytZ9OzKPIAYDtqTr3eSJO0u+g+iyyaKQixOLtTwX3jJpnJ6
    ZDIMSigka2sYN8qLoC90tZ5niWreVzEWLn6TKlrRBHiT1GJrYoe11yfVjB+aZvR/
    njTgVRO7qS3UCfc9qTuJ/WmNTZD5Tl44ZNk0LSk6qONCB5bxmMQwJns4hAVPbkPn
    G4fU6h0Ff08mezOjho/1nGi2BKDn+YebNJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524672572; bh=
    HOPGk2qzPX2v1ymgMAFsCZEttHGwRXlUtvYnV0aO4do=; b=Ggh1HRpzI3kueeAo
    T8x8bwqkl8MHY/L39stE4IqDkKx7Q/HH6/N2ZerT2EOxyVEjbp2meaMjvpPip6JR
    rW1Y/MNA5BMyNhwLzaP5LSPraw57/IWSa+q81uT5LPh54yv5GSizIybT0HBqznQc
    xZtv6dMY7WWyD7rCqxSeVeY9ppgTc0B2WqhkkA6Nnh5pSpIx19in14OZXDPTJxe8
    abhQscJIUIIPBOUFEru0g7doVv06nIGiC+97XEHrZvvC0dsKDXUsqy4/aZXdxQmB
    sY0tdBVcFNMup36/fS/zkZPQQKQaChEVfh6MjmyqSfMH2H5B1YcqIKBGZCSD3Xyf
    df+FCw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBTO7pBG/f9pankHrIV3vi3B6AOROixdcCFGKx+xdhRUvrDXcBANsqgfhcVeBKy+Jf5wB2s6SjQ7RleHqHrISaR4lXwT9sLXpOn4D/gt5VRT8KORRJ31
    K4jBH/zpoLXIHblHWDhxUo6aXCP3JCiGZNyqY76GGL2cxrqZbFWgwnfk3aawG2u2cYDdCfP17CY4EOvi8Xi9P3jEqDw6+wXmlQ1Ft7jyRmc+LJqMyCBv3pKJ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=LxDo8AOQR0MEk2g21wYA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932122AbeDYQEl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:04:41 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40331 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755477AbeDYQEg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:04:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, netdev@vger.kernel.org, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, albert.aribaud@3adev.fr,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 17/17] y2038: signal: Add compat_sys_rt_sigtimedwait_time64
Date: Wed, 25 Apr 2018 18:03:11 +0200
Message-Id: <20180425160311.2718314-18-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180425160311.2718314-1-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de>
X-Provags-ID: V03:K1:O0tl35BX+FVRGiY7DYb8Pwh7dwKgNq2jlymsKjQ7HmDg4+G3hmU
 UnEhnvY0qus6+HVvQPkhVOb9huQ4jzCuAk0/sOjgGGTKiczmKZwpMQJZXM37sSdcW60wRRY
 WPFRkWF+Yci9KOyTVo0souBilbJdSGecvBCU7TyWKz0u6TApA+OoS5w+XnGQMnWdolbXyim
 1yPBMlf2oKXo5v5eYG96w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WbVlpHaoNGg=:ZwReD+umxITXrp3SV90uTG
 2wOE5mvsGkezl+JcfqILpWaKumCzXblvtd7NDNTzrFdob3t77cdrscxh6DwmMGYr2kLF174Mr
 01HBaMIzLOQMmNlT+4b5BLC4I44vxo5KrPsKRJ/1hPN/7Ea7AAPM4Qr5oBtcpZCEdZvJfmWer
 CeX5h8Tpy2oFSPwvI3cSEaI0+nv9mo6ufoD/ER0fCumBGHFSpLtdOWL3BJjkTD5hpM3ExJnoO
 DH6XyF83pwvE62uziiZlk6T1f2vPrXcja7LbbEJvz77JnMZNN4lypZh2Lf0rWsArVvrIaB3N0
 lArOTd4zTPyQdOwyK/BKlHvbn393DhW4zVNzLHPpP0nfwDKtlioGCtMJMKCGnxFZRFxg3iFTI
 0aOtQbwy2yrgm6F9Fc5KFLHRGEe71hn2RR6hf6toFPO/JCUtVVKWkfZ9tVX0WrZ9YtBFMFCCX
 Zg9RjJTQjlhYxi4U7bu82V6QRhnqO612xLNr8DrBvymyLPhuyvYgGj1c/U68rBe4m8htYhEiR
 lK2s8BJm7jX+CMt9XZj9+ONGq4NRWSuw5SPZQUM2DtHWeltvDuMFJvoNhiRFzOd5/e6bogUHF
 vm43722rWpikKGmvx4Z/Sih/H8fwwxLiBa1eYHPflqATwcIOhe4UUQIWKm05SAbtQs4l9MP9A
 wTtxp1MMYnAJwY9MLwuzzw0eDGDw6lVd7C7G1ALcCq2XbmwtDIUO8/TpRd7gdo+2BbIk=
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that 32-bit architectures have two variants of
sys_rt_sigtimedwaid() for 32-bit and 64-bit time_t, we also
need to have a second compat system call entry point on the
corresponding 64-bit architectures.

The traditional system call keeps getting handled
by compat_sys_rt_sigtimedwait(), and this adds a new
compat_sys_rt_sigtimedwait_time64() that differs only in
the timeout argument type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/signal.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 72609c6835fd..1927fcfa7077 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3249,6 +3249,38 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 }
 #endif
 
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time64, compat_sigset_t __user *, uthese,
+		struct compat_siginfo __user *, uinfo,
+		struct __kernel_timespec __user *, uts, compat_size_t, sigsetsize)
+{
+	sigset_t s;
+	struct timespec64 t;
+	siginfo_t info;
+	long ret;
+
+	if (sigsetsize != sizeof(sigset_t))
+		return -EINVAL;
+
+	if (get_compat_sigset(&s, uthese))
+		return -EFAULT;
+
+	if (uts) {
+		if (get_timespec64(&t, uts))
+			return -EFAULT;
+	}
+
+	ret = do_sigtimedwait(&s, &info, uts ? &t : NULL);
+
+	if (ret > 0 && uinfo) {
+		if (copy_siginfo_to_user32(uinfo, &info))
+			ret = -EFAULT;
+	}
+
+	return ret;
+}
+#endif
+
 /**
  *  sys_kill - send a signal to a process
  *  @pid: the PID of the process
-- 
2.9.0

