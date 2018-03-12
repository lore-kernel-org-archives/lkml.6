Return-Path: <kernel-hardening-return-12411-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu9DmjAoL3SaTlrfvStVQKLt02BFydkmZYu+d2ukQ+mgJWIz59Jb2SfzSRgENzxlaZAO0hV
ARC-Seal: i=1; a=rsa-sha256; t=1520830946; cv=none;
        d=google.com; s=arc-20160816;
        b=wDXuctlGywlVB+8JLXRKavqOANVplHq9Z8ofnZwiHL5tPfuc7bA0EOKsP+jtIgjL8i
         CRVt2rroIlYD+2/swoCQto6CWoqX7X8ch0hQOy2QUXJbysFs1AmjASeMgCfoj5C2D5Ck
         dsxjuryw+7AsEs65MvrMElCa+ZCFPG23NEJvDLIyRvDi9vs+5xWiNSeFVVKdGP6PFZcO
         x/j2Sz4P98Hr3epsHfAeQ0vkzejwktyJlJxnv3DBUc8VmsbMBpXxs3uUM50PdEsrnWp9
         cfz9Ng/nygSt3oEh6oO1i/Vaz99MYdAOYzeQg6J2DHJiUkQm1otrkFOBtf1l0Ji1W2pr
         bKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=XOiurX6AV+s392nVo5LsWZ9u7rothzZI8FGeu0MetSQ=;
        b=beO0IGzvbLMWl2CJEYBCO/NAiv6nrfJiYeX+l+EOT9Lh2ZbwoN/y/WxUfRIM3f8UCi
         NTVmRQUWfub0M1sCm9fhhs8sOSJY9K7LTRxFQtTe4hRGfuvSg8UZmmS5fztgMvYUCASJ
         aJrKO3U6ofqNjeaOHEeH1KeAMK5LpjxJNX1klDQzwpSyPBOmET9Q+yGdkgCom9WIvloU
         t+foNPl0rVreSy5jaEzlO8CGdJGvgWbeNftSnoyb0jXnpV2DC1GGbLBgcYtdtgtdssg5
         Hp5F2kXS41Xa/CwtdIse3jG3OjgNIrR9hUQmVeXNOQELCnAUMqbpzBfMBxmFJlq9zuuM
         uUKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QA1v1I+P;
       spf=pass (google.com: domain of kernel-hardening-return-12411-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12411-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QA1v1I+P;
       spf=pass (google.com: domain of kernel-hardening-return-12411-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12411-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 11 Mar 2018 22:02:04 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>,
	Alex Elder <elder@kernel.org>, ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] rbd: Remove VLA stack usage
Message-ID: <20180312050204.GC25480@zzz.localdomain>
References: <1520830180-25452-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520830180-25452-1-git-send-email-me@tobin.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594706055475539474?=
X-GMAIL-MSGID: =?utf-8?q?1594706830023590006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 03:49:40PM +1100, Tobin C. Harding wrote:
> The kernel would like to have all stack VLA usage removed[1].

Can you please stop writing this?  The Linux kernel isn't sentient; it doesn't
"like" anything.  You need to explain why *you* (and other people) believe these
changes should be made.

Eric
