Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AH8x224+XWDByvxDSLyG7QaKUFpAx6aV8e/NysCebK+Euq/ybPOs7ElVbYdOTP9dFRGDkFPAUt0g
ARC-Seal: i=1; a=rsa-sha256; t=1517500244; cv=none;
        d=google.com; s=arc-20160816;
        b=b6p0MS+uP/TMz27rUOx4p3aF5XNESO0D4uoaKpAY2U7DqEIm5d6HM7FI5jOyXV2uoW
         MPHSB7mMJo5jxN0KHMnJG01RH6qq5OkpL154LLLmH7JJfJqMrS/6sihinSbkSgriPhoI
         mkbW7/FSJnrxTTl/YrBQwRQOsOGYCkTZqKaVJPkBl53XX9E/PAxgJ/s/1u41ZMYnc4Wq
         Th1GWyNKvjctK7MtUt8txcJw8bTF2ZN7qCBE+NWVYSucUkqoFdupO0t1W+h1gDH94IGf
         s3G1RhibLcPS0lRyEzY/WZoQBHfHbFm+WiUAMmCsLjCNrpJcAG5G9XH8hGz6DVF7YEhq
         5SLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=WTzEEsjpROi+5RBPrxQS3VzTLROzo2/fddvbTfp6Goo=;
        b=YNMfrbNB4qt8QceEs5j2eNAWtujW/lmrc3dwsAwsc2vu9G/Q1MFkGk9blXym2UyAeA
         I4r06TAtYJPSf/097ViPwCq/lJXDmKmybus8qC/J80OiS8gMONOUhjzFrslRGN6YQfYu
         eH1JCi0+hOi4npjrSeEWZlmbBLNMxOhjm7By5N97tC+O5RF5i70PSEfCAiPrKvWZqYFJ
         tfKzTwWndsrg7RnURnvb5hVWXmA80l9IPIaK7TosRGA2H14jEgxu3TpVMdCEyHHuT79v
         faEASG7iMfHRoUWBraH9x/f3QS6GnGELv7RaEXHDHSGXZKoajHvfELuOTs3vmrKd5tan
         FUvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 1 Feb 2018 09:50:36 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>
Subject: Re: [PATCH 0/7] objtool: retpoline validation
Message-ID: <20180201155036.fnhkxcvpswvnjymu@treble>
References: <20180201143421.088202488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180201143421.088202488@infradead.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454988302775?=
X-GMAIL-MSGID: =?utf-8?q?1591214336333673355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 03:34:21PM +0100, Peter Zijlstra wrote:
> There are the retpoline validation patches; they work with the __noretpoline
> thing from David.

For the series:

  Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
