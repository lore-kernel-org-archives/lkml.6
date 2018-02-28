Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x225JHoaeRSoyQtRZ0aXLiJ7A8TgFsU76lowUw5DNKswGfEn/4vYPcXAGo0S0/hIyJrDdSN1N
ARC-Seal: i=1; a=rsa-sha256; t=1519844404; cv=none;
        d=google.com; s=arc-20160816;
        b=hAeRr/C2i7HO9vf3yvLUIagosrvZfDUDO9coYyqzRG4vLL+4Q0AyXipmy+S4KsQ71G
         0FQ91+3m4/QSz2fQpYZ68XTIGqL858Eclqj2ViKp0B5EXL8j0la/+geLP7TxnYID/Ic7
         tLbkPzky2LLlSyGeEFlMcFdsCqVQyNTfxUpAgbTZtY9aCTxgrzceFuleotHWDxWdiLmj
         DnUgSrYP1nXUA2FYUxUJjZ2o74GHmM8U9AXLvOWIq7ASgsVZwk1XoEgqiLM5rB8VW7Ku
         ZtK4PJQ624pvrP/mJuI4U1mdKZIb+tkp0mng5r4qcv1dWgIhefMwlTh11qaET1q6ZUoh
         o4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=4ucB0fi1GEhStWc5CY2tpfeiiwuwfP2S2yuABbPCZdg=;
        b=EZwysefPriGwDmHySURoVG8nfZ7n5yO5dfT9itPvsE7zdL8WFQpEWTiCt/56s0lYHU
         va8CxXhxJpGhkmkaoSneluRbnLIH5y3NiiloLEInyyLM73Dl8S5gyexPC3ExF3HuLPfZ
         k5YjFMtdt/NTxcGwoGTsLNr8XP7p7N/Xg5EL5tyLFgXiXwbyNAldJ4y1NU+J5eFL3KKO
         nIZAZUtrO7rdegfvLFI0A76RNV8pg998IkBIjkkedMDOGqA8FLM2pwgJnz3gv0soe0C9
         fTS3144BoS9Ay3gE1kI5NHTkqOuhL1EjvS0vxKdVpNNPqSmj24P8g5g7LSi7KKor5uVF
         HIbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Re5YHoWR;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Re5YHoWR;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] Documentation: Update ncurses package names for
 menuconfig
To: Arvind Prasanna <arvindprasanna@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519801192-31201-1-git-send-email-arvindprasanna@gmail.com>
 <43a91eb4-646a-b4d8-5b3d-b0bfde0019d9@infradead.org>
 <CAK-=9LoNfYP_-tm+W2GvUWjWgs=BZ-VRFmVNzTCadzQWaee9yg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e484c42f-4fe6-10f5-dab8-cfd749911486@infradead.org>
Date: Wed, 28 Feb 2018 10:59:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK-=9LoNfYP_-tm+W2GvUWjWgs=BZ-VRFmVNzTCadzQWaee9yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593627124178304067?=
X-GMAIL-MSGID: =?utf-8?q?1593672366054215269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/28/2018 09:39 AM, Arvind Prasanna wrote:
> Hi Randy:
> 
> On 02/27/2018 10:59 PM, Arvind Prasanna wrote:
>> The package name is ncurses-devel for Redhat based distros
>> and libncurses-devel for Debian based distros.
> 
> The above lines are part of the commit message and the patch says to install either ncurses-devel or libncurses-dev based on the user's Linux distribution. Would you prefer I add my commit message lines to the patch as well?
> 
> Thanks,
> 
> Arvind.
> 
> 
> On Wed, Feb 28, 2018 at 12:31 PM, Randy Dunlap <rdunlap@infradead.org <mailto:rdunlap@infradead.org>> wrote:
> 
>     On 02/27/2018 10:59 PM, Arvind Prasanna wrote:
>     > The package name is ncurses-devel for Redhat based distros
>     > and libncurses-devel for Debian based distros.
> 
>           ^^^^^^^^^^^^^^^^ That's not what the patch says. Please clarify.

For Debian-based distros, is it libncurses-devel (above) or is it
libncurses-dev (as below)?  [latter is without the ending "el"]


And what about the other few hundred distros?  (rhetorical)


>     >
>     > Signed-off-by: Arvind Prasanna <arvindprasanna@gmail.com <mailto:arvindprasanna@gmail.com>>
>     > ---
>     >  scripts/kconfig/lxdialog/check-lxdialog.sh | 3 ++-
>     >  1 file changed, 2 insertions(+), 1 deletion(-)
>     >
>     > diff --git a/scripts/kconfig/lxdialog/check-lxdialog.sh b/scripts/kconfig/lxdialog/check-lxdialog.sh
>     > index a10bd9d..4353e40 100755
>     > --- a/scripts/kconfig/lxdialog/check-lxdialog.sh
>     > +++ b/scripts/kconfig/lxdialog/check-lxdialog.sh
>     > @@ -55,7 +55,8 @@ EOF
>     >           echo " *** required header files."                            1>&2
>     >           echo " *** 'make menuconfig' requires the ncurses libraries." 1>&2
>     >           echo " *** "                                                  1>&2
>     > -         echo " *** Install ncurses (ncurses-devel) and try again."    1>&2
>     > +         echo " *** Install ncurses (ncurses-devel or libncurses-dev   1>&2
>     > +                *** depending on your distribution) and try again."    1>&2
>     >           echo " *** "                                                  1>&2
>     >           exit 1
>     >       fi


-- 
~Randy
