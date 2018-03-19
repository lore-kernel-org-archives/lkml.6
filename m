Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521502963; cv=none;
        d=google.com; s=arc-20160816;
        b=SxJzwQ2mN0coazj041Ojpm+U3dMTjXkaNyyUihQatIi3my7EZ8VuJ+ZF3whHMLI91V
         nf+y7zJ4pMQDa1nAdNiWAGGBJq06AQa9iVy7OhSCs9dDtfNbYUI5an0v20ce7BwELD6J
         6q7X8PzQv5DSDMOAM5CJTPtm8Vp1VEa151tF+ampI2mciaWl+MaTtvCyFvmYXBHXSdGN
         xXvDX8HhV+yUeMicU16Ek+PJ/XC9M/OS/fIzsyR9vQAp45MNxL/V16t/+xUYLYcfIWE7
         FzMrv4FwYTB0wFz/+MNu2UxsQBL3RkZNvYrwnXhlZhu3nQpTwQjuAlp6m+m79QwvuTdG
         76IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Nm7ZX1ulvaReOqAGBrzJRorz1FwmkqJjNjydeGA/FJw=;
        b=FY2/kfiwi2yUNq+KHlV8xqlxJIBUm3fpK095YSQvW7qQC/bsQWiCE+LMP+Yfu2OPuL
         Iu6c3AQm006M93+QjHa4OWBkH3sc6RJn/eax1MlkBklFjPWNou8oycmaWQyE5ZQklacC
         mggUdKb6F+ggE8RziqN+cdXF7EoW9EXAj5+e6SkmX1PWnDZq1MkI5ljyzJkcvpyT/00j
         NTndpRoyhKRxarrB/bNOCIjO4FzZtxKihi+L2oyMToIddFYUGK9ImwEgIjCVjFlrGr7x
         ex1VG4b08GR5AHCwL5fcpK5VT5Seky0baHA6uTWaF1yD5czEOYld0t8h5eMUAZ/S5lDP
         IbXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IcWiDQaq;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IcWiDQaq;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtGLgeujTLVhwYI8803N4yB5XEv8pLUp6JEroJHVHyzsx6ws4HVtfblktLJ7EKcimeadECGXs6LL5Y70VznhTA=
MIME-Version: 1.0
In-Reply-To: <s5h7eq8vyva.wl-tiwai@suse.de>
References: <1521423963-24677-1-git-send-email-ruslan.bilovol@gmail.com>
 <1521423963-24677-2-git-send-email-ruslan.bilovol@gmail.com> <s5h7eq8vyva.wl-tiwai@suse.de>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Tue, 20 Mar 2018 01:42:42 +0200
Message-ID: <CAB=otbTjO_e2Ad2C=PR2uP20i0qOkOpx9uNJgqYfThm2K1haPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: usb-audio: move audioformat quirks to quirks.c
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jorge <jorge.sanjuan@codethink.co.uk>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595328658262670421?=
X-GMAIL-MSGID: =?utf-8?q?1595411491148818440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 6:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 19 Mar 2018 02:46:02 +0100,
> Ruslan Bilovol wrote:
>>
>> Offload USB audio interface parsing function by
>> moving quirks to a specially designed location (quirks.c)
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>
> This one is applied now to for-next branch.
>

Good, I'll drop this one from my series (although don't see it
in the for-next branch yet)

Thanks,
Ruslan
