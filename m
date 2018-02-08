Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AH8x226HoSW6V1i1pW5Mqf5pN8g3v4LQuBsIpdUvf3tgkK3EtqFHNQdSs1BagnFNTBnfDqGguPwe
ARC-Seal: i=1; a=rsa-sha256; t=1518114424; cv=none;
        d=google.com; s=arc-20160816;
        b=0qX0Kojhc0QK4x5+v70zcgvsmeMhavmvw2o3UBd/0rA70qUuKkHebIbcaYWrUPcnpr
         P3UP/Z4WTRf/xYWaFvIAT51/lENXvSVm0y0tzBlWKTAucgQdeno4Iy5ptLY3/8peJpjU
         T6lPpRhDlLFmzCNSMNzFT4r4p9pb32kKK+I93ecWalzzinikpUjOhLL1vsWLIJ6QG+Ye
         Q6wa1HEaSSFMCBX3j32YDaUfGM9AhzWNQfQOCZep+mY5WIvG63Va6LjVjxu3wyWutXwT
         iCqO6JUN5H7Yru8yJAvimkq5h7KJLKhWgLTm6l+AiihQTpQ1tLCKRbzV/nuei/KoNoY0
         rghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=K85BgCLNJnPqnDFnD5+oBCZCxolY9qvIRENDQdOvRAE=;
        b=SvK4zqHKSpR5XTkVSM7Z/PTL49k0VjMycMSQj/OJZ6H2cfFoCfh7qb729ttRnwcGp+
         1PDbbXXyvqA+H9tokXb+6Wtr7fIzxGGWYs4xUUqTqY1Zj8aI9y510JIiSe7ynrFOTzbA
         OGzkTpSuj16gloRuT0whrSV8GPtxbGQOn0eRg6RBR0cu/wiMUc7cAEwSNi5ejbkTrwH4
         agv4QoR+sgXLObE8iZ8//VFjfFQBlK3ygR9N0lbDljgijZcKLq35TInzSTdvkx49C+3S
         AmbdQA4t/TZqoZeTLCz7OZrAyQU9TBN9awWH2Mc8YKh6f8F4vQFnJE/eKuyc+P+hdRaw
         qXPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Thu, 8 Feb 2018 19:26:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rolf Neugebauer <rolf.neugebauer@docker.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
Message-ID: <20180208182645.GC577@pd.tnic>
References: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
 <20180206142444.7xxegyyyfwskwrxl@pd.tnic>
 <20180207143428.GA31944@kroah.com>
 <CA+pO-2eiim-6E8VLAV2K3s=pqEv7QcV1f8znLeQWqZh=zKWVVQ@mail.gmail.com>
 <20180207181254.GC8698@pd.tnic>
 <CA+pO-2e=nZJeAR2j8Pukb=E4aHgvDXc9Tw4poatrUcD15Wi1Jg@mail.gmail.com>
 <20180208145348.GC7964@pd.tnic>
 <CA+pO-2c1WPr7UTtqMQBCzOzKr5ex=mu4URm=d=Of1+bn-jHJUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+pO-2c1WPr7UTtqMQBCzOzKr5ex=mu4URm=d=Of1+bn-jHJUA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591660958258362388?=
X-GMAIL-MSGID: =?utf-8?q?1591858350084075482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 04:25:58PM +0000, Rolf Neugebauer wrote:
> Here it is below (same disclaimer about crappy mail client). If Boris
> is fine with the changes, Greg, I can send it properly with "git
> send-email" if needed.

Yap, looks ok to me.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
