Return-Path: <Yixun.Lan@amlogic.com>
X-Google-Smtp-Source: AIpwx4+NXmdCZxy1fehWodzP9lvzY9MexXGNismUq/Vf67qwfBsEW7UvXubBUb5dI/8MaYojlTup
ARC-Seal: i=1; a=rsa-sha256; t=1524471178; cv=none;
        d=google.com; s=arc-20160816;
        b=NKEQ6eya0iaw0n/RO/9J/0D8utYLtvApqeIvU2ItEDG76l2TCe6SFkdd1IaBCBbq9/
         dJRzC0UXuY0C4eaBc3/QpkHIxtOezTnwGOsPMcL0hqAxHPMpbfAcB8DIQqFNSq1nmZH8
         Z7X65PBBcS1cnaZsDvGU6PkXg5xVFhKqeZVS9jNrJPjbwRCV8ZNwxNHkdObPqReyx5ov
         c4PMlIg9CbW8fLbIwoIfegIx2FKmj3I46R7WoyEl84142CNp4negJgGVmCbjYQamjQjg
         PTZhI2qEcwLG2RwMuMWqhnKlWQ05UqjaCoMK6jxlDB7TobU7Si2bvewh4k3bSrqnAJsM
         zmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=csQZbikih33U+dM7/skQBhRCXo3k3dSpTrzM+sl2/bg=;
        b=YN4Mqw+mD+E56JeZgEOd4GCCjFu4XNAxgrYPAVkfPuMeehK/N678LOZ50o+49JavwA
         ebXdj/4q+mpAyC9fXVDWtZeKDAXcny5Je8C1iY5KueJyWPjWsyly/1ILmL97nSg3chfn
         asiQJxAR7Z7TRP0vnfcOvcdtg7PI/gvCA30YjE6IpyoTAbFdcauwIrJ4PCxDE1c1AvTy
         Zt9QYktW6ufpyCNdfItdVsKVrBLVLaLJERuDdrOcLrIfoRrocUFeLz1MhgPW/IiVgsok
         gV07RN8fDyp/MqbLfxyhLhzAesxMiQ03jWGoDjj+N9jnvOULN5ghEAO9NU69ePLwqoHD
         DjAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yixun.lan@amlogic.com designates 58.32.228.45 as permitted sender) smtp.mailfrom=Yixun.Lan@amlogic.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yixun.lan@amlogic.com designates 58.32.228.45 as permitted sender) smtp.mailfrom=Yixun.Lan@amlogic.com
Subject: Re: [PATCH] dt-bindings: reset: fix invalid SPDX license identifier
To: Thomas Gleixner <tglx@linutronix.de>
References: <20180423152907.5113-1-yixun.lan@amlogic.com>
 <alpine.DEB.2.21.1804230939350.6136@nanos.tec.linutronix.de>
CC: <yixun.lan@amlogic.com>, Philipp Zabel <p.zabel@pengutronix.de>, Kevin
 Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Neil
 Armstrong <narmstrong@baylibre.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <2b97cdb5-6cd3-34fc-17e9-4df8cba82850@amlogic.com>
Date: Mon, 23 Apr 2018 16:12:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804230939350.6136@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598521231346509320?=
X-GMAIL-MSGID: =?utf-8?q?1598523890256268880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Thomas
	
On 04/23/18 15:45, Thomas Gleixner wrote:
> On Mon, 23 Apr 2018, Yixun Lan wrote:
> 
>> This fix invalid SPDX license indentifier, also move it to
>> first top line according to documentation.
>>
>> Link: https://lkml.org/lkml/2018/4/22/713
> 
> Please do not use lkml.org links. lkml.org is not always usable. Use;
> 
>  https://lkml.kernel.org/r/$MESSAGE-ID
> 
> instead. So this would be
> 
>  https://lkml.kernel.org/r/alpine.DEB.2.21.1804222108120.6136@nanos.tec.linutronix.de
> 
> The reason is that kernel.org is very likely there as long as the kernel
> exists, but random archives can vanish, change their URL, etc. The above
> address is a redirector to the marc archive, but if that vanishes or stops
> working the redirector can point to some other working archive.
> 
oh, never know the difference, thanks for the info

>> Fixes: c16292578ffa ("dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller")
>> Reported-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  include/dt-bindings/reset/amlogic,meson-axg-reset.h | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/dt-bindings/reset/amlogic,meson-axg-reset.h b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
>> index ad6f55dabd6d..4a8e52f68fb7 100644
>> --- a/include/dt-bindings/reset/amlogic,meson-axg-reset.h
>> +++ b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
>> @@ -1,3 +1,4 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
thanks, I'll update



Yixun
