Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AG47ELvxQ4loTzIcNZ5Vn9MLy3VX041eKOf69P6E12GKSPXiM7A1zkrP4S17YsoeslrlBs/lLdiB
ARC-Seal: i=1; a=rsa-sha256; t=1519211756; cv=none;
        d=google.com; s=arc-20160816;
        b=THt9K658dyZZ+HrZ63bfx12J+CG/qN9WN6+22TIWyizNU+HzmZ/cX5Tz9QgMGCC8GN
         pabWeCfyjuXhYjudFBZYhUbzwppMB6VTQ2PKhYVdcH048BpHsNuc0YuN/UvFChFNCmJJ
         g9nf0b5ZQAF8s+UjJhVsMLaLR7gRWEryWBREUI5AVQzFS4i5N9kr+jird3mtuyuyiMr+
         2TjFMsVj88nYGC03uE5+lCQw9o6M8DVdbY/s3owQQcUU0wFuEYhgWsP2PgWLWLk/nrAU
         poiEO8Osz4KUJI/UzGnYbcOKsDfdVdy8Kh+fu7/Z0UPq5baT+NjOU/OnSJm6/gYQVqdm
         eBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=RBqTTkiE1AAMt/5qIvZUDySK1NRpiQMBCDQDUOfums4=;
        b=rrvRFdRPMbleCyLHEO1TXMec1Gv1P+fnCEuzyEqphzguimFjXhXzOS4IPDwPEaoXBO
         +3RRvF896cn2lbPhTOPYRHEzWS9SlmiQKy+BR/83qS/RRtXKOqO1nK6y6Mz+NTn/0M2n
         GXMrk+2L0CGUK4uNWZQ/hRgIaY8gYhHP/ScFkQGqd2i3lWFckq89RcFrT5a0oazq2TZy
         h0TglJH6KdjxIcW1qjqaNIrq2HDaDj6HHBt4Kwq1vpTLilxYoTvqR3V8+s/LDSwS7MwR
         rhG2kL8OiKcV3N2g6olXmDFpIYgKiAC6EJ78AUNCieE5807LrVEZ6YLNUp3xcKvobP1w
         UoMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.197 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
MIME-Version: 1.0
In-Reply-To: <20180221104558.r7qgxyqshy37gej6@mwanda>
References: <20180221103928.19599-1-quytelda@tamalin.org> <20180221104558.r7qgxyqshy37gej6@mwanda>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Wed, 21 Feb 2018 03:15:54 -0800
X-Gmail-Original-Message-ID: <CAFLvi21KhXb0+Z3V6Dfv9QrK3via_r6Ggoku5D3mpG5NEYeQ7g@mail.gmail.com>
Message-ID: <CAFLvi21KhXb0+Z3V6Dfv9QrK3via_r6Ggoku5D3mpG5NEYeQ7g@mail.gmail.com>
Subject: Re: [PATCH] Staging: gdm724x: hci: Changed camel-case to snake-case.
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, jonathankim@gctsemi.com,
	deanahn@gctsemi.com, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K0:flmPbj76D8nxUUTrMqsepVCJqkhrubqrrv3BTzF34hYKbLsvUOi
 1Zn5LNMALqRaobzA8q52eFCRT0UAjl8BEEaCV29wNEelIvSr7WHhwZQWb/LVd3iGdkjXorw
 86liDpd3JBNIstHDDUYumDWf5//wH5AH1/DGEhbwG0uPuwBbOnyr83dWgepnlQ0wCkZdRgF
 +kHylJe+GFjPr3jZ8ECoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K0pM5QqAiQ4=:aFT0A6y0WZDwRgALCCKr8h
 s7L2bWUfLoPoA8dmgNhFroV5LJs5YjGkqKjrIw+i1BUGC5QcpW0oeldvGf+VceJtX3Nl4kuzl
 +BBe7ssAjGzhreKiAW8oBElp19hc8pwebRdknf9MJXgfwYfpzJ3m2KOGmSaNmSqqkZkqSbwxU
 E2uhyUO5in3NotGmsR4+s7cS6B5nMZygfl+AV3BObMqqS725M2jitwBqVgis+rDYJXc6x8p7o
 TxwedC7fPEwczkQZV0jsklZwmHlr6w57qLq5EcFV2nW8Rb+o3rWfaUmYdmlvxX3jcIeUPlift
 iTuPgQ5EokZZMtncsuOvGEfn+DtSIGDCxF7t0LTcDewWsbWxLC9jZyGlFSCVxmJLxzXrizT3Z
 Ls4mLW7t8J+PiKSHN+Kv/bitm4X5q+u1L4gkqHw/ttiT5YFs20am2HrLz4KlPV1tKGYOh7x7r
 LEOkC+GsIWNJutnEhGldaDTdlxMT0jCOQpe2wyeb2HJ83Oyv71xDBJOB9W968ki62liaVlVLK
 DDaA7jECXskpbhG4SFiCtKf2p7uhLFH/W87VwYV0h5Ub2WFeF7dE+AVPOdBeZ8xr0YVuBgNBw
 dgKOWKIFhkoqnTqazesMeo/zOtGV0VX+wHeHrJEspm5B7A+PraDGvnazIaVSyuCsDGNDg2lZh
 ucTaa0nL06gILLd7ub0RHmfEGLCBEZEvjPHoOdyNZjfpay+8nXYX6k4KVzbyQzrWu7T9XDzPn
 8EdZrzn78LBvqqPj9hhzHpTZboB8TLXVw8HWAghMcn3//BwU+ckC0w+QjF0=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593006710117877151?=
X-GMAIL-MSGID: =?utf-8?q?1593008987244911818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

That could be the case, though I'm not sure where to find any specs.
Though looking through the history of this driver, it seems that some
of the variable names have been slowly changing from camel case to
snake case.

Thanks,
Quytelda Kahja

On Wed, Feb 21, 2018 at 2:45 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Wed, Feb 21, 2018 at 02:39:28AM -0800, Quytelda Kahja wrote:
>> Changed a variable name from camel to snake case to fix a coding style
>> issue.
>>
>> Signed-off-by: Quytelda Kahja <quytelda@gmail.com>
>> ---
>>  drivers/staging/gdm724x/hci_packet.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/gdm724x/hci_packet.h b/drivers/staging/gdm724x/hci_packet.h
>> index 22ce8b9477b6..f8837c7103ac 100644
>> --- a/drivers/staging/gdm724x/hci_packet.h
>> +++ b/drivers/staging/gdm724x/hci_packet.h
>> @@ -50,7 +50,7 @@ struct tlv {
>>  struct sdu_header {
>>       __dev16 cmd_evt;
>>       __dev16 len;
>> -     __dev32 dftEpsId;
>> +     __dev32 dft_eps_ID;
>
> I bet this is a part of the user space ABI or there is a specific reason
> for the name to match the spec or something so it can't be changed...
>
> regards,
> dan carpenter
>
