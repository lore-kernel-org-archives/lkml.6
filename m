Return-Path: <segher@gate.crashing.org>
X-Google-Smtp-Source: AIpwx492/tCwATdMFx+h6bQaPz0W7Wa7nuv7aPggXzzf6sFtatvJjud8mSgu7vPc4Vb0f8XcIf8t
ARC-Seal: i=1; a=rsa-sha256; t=1522274452; cv=none;
        d=google.com; s=arc-20160816;
        b=lmqHO0CmvpIoMLg/a1lRB8IeGZDTelSYfz0aklGDyYMAt/EboCi0OyONqbKZfjB1ni
         JmAUHeOb9AuENriFFUsossXvLo6NpbB9tXnfEFKot3nCFnrLI+HxMeTkcahIlsDoSXYZ
         rNUTtOKS1z+bv4vHtlpVHuA+EYjhCO34t0J+g9ImOsldb0ZmzfP0yok2X7Ok7bqf6zbu
         mBpw+w2Y/tYw5rnX92GRnNVCoFk1UAHH0mpJ50HGQe7czdeLONcqnvYTmrFkPsOz2DWN
         jQAkkcu0//BzpVIh2SnxWiT4Oi4KXpWGTb//YbVfJZ10feRqKsqiYuPkJBbdB607ez12
         2g1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=s7Bk5yfSMDChcBY/3QClGubFoF4RLsfuqaXisOkwtXg=;
        b=qQyFlokGwumSUkg5KvI4+eK6zd05MrhAXOgfnDTPPLyZcXcK/wOK1lYLpm0/Uq+VS/
         5aH6JPdFOPHpJJRck5IPwD/q4xqeHV1eFbMf74Ki/7GETm8wXLZ8BvtFp9OsEyv3WlQU
         8OMmtRnyQaTOYIEEItDaUVHcwdxbN0ech/Bv+Tumo1dmbaZLnMsw2YIP1d67FwWBoDtf
         uEqgeDZ7L7Odzzf9oB8HqgRMv/scsz56COiAL/8+xQghx3vWKA156Asu0+Wsi1MLSrXc
         yj06Wgh0xEnWZ3nFGBpq6DDtc2CEcYPbwD1Z2BAK02PYyJrkjmD4Vcr7p8JSrQydG2vA
         akmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of segher@gate.crashing.org designates 63.228.1.57 as permitted sender) smtp.mailfrom=segher@gate.crashing.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of segher@gate.crashing.org designates 63.228.1.57 as permitted sender) smtp.mailfrom=segher@gate.crashing.org
Date: Wed, 28 Mar 2018 16:59:31 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch 3/8] rslib: Add SPDX identifiers
Message-ID: <20180328215931.GW23207@gate.crashing.org>
References: <20180328205138.301218351@linutronix.de> <20180328205554.496966175@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328205554.496966175@linutronix.de>
User-Agent: Mutt/1.4.2.3i
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596216464368610748?=
X-GMAIL-MSGID: =?utf-8?q?1596220455921605657?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:51:41PM +0200, Thomas Gleixner wrote:
> The Reed-Solomon library is based on code from Phil Karn who granted
> permission to import it into the kernel under the GPL V2.
> 
> See commit 15b5423757a7 ("Shared Reed-Solomon ECC library") in the history
> git tree at: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> 
>   ...
>   The encoder/decoder code is lifted from the GPL'd userspace RS-library
>   written by Phil Karn. I modified/wrapped it to provide the different
>   functions which we need in the MTD/NAND code.
>   ...    
>   Signed-Off-By: Thomas Gleixner <tglx@linutronix.de>
>   Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
>   "No objections at all. Just keep the authorship notices." -- Phil Karn
> 
> Add the proper SPDX identifiers according to
> Documentation/process/license-rules.rst.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

if you want that for the changes I did in d7e5a5462f68 .

Cheers,


Segher
