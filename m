Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525295308; cv=none;
        d=google.com; s=arc-20160816;
        b=d+i2DV1+8g4/ikIygXSE2uQnLCakWzX7F7Jj8gLCFyp9NJgWbaT/P9ZoJb/5RVc9r/
         KH1H0yLjP3CiLchFi6X1Q9kVRljo+dirz75PLwYmcMfagvqPwZqi0yL6YO6IdzltcM5M
         Tg8FyLNOGw+EqW9uC6jAnfpws4dpLvbnzJK3gXcYOgeU3aHEaSoK1AOZgsYA97FLaa+0
         Ekh70TQ54ANCt6iec9u7II/3DW8JL/IjFnZ83uaisztSxW+5ZfcQkalRgDRiYBT3FVYR
         X90UUQaBxi4iutcf0b7TevV89Uy2fl5J/K9LZFjBXT4WlJscs4hBwuJPidWcAB2GI9Qg
         Lpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=MVH3g2Vjr3yK9EtqIL6rg6MfHbORyHFnMP6FGFvRoTw=;
        b=V4o63YKKrTn2EiMygG9GxLPbXuvpb86YP7YS3yxXWxNJHJ6Yn9V8AsR4I4qm8fSKM1
         Diq59ChHCoMXydazoACJbzXIb+uKZtColNHqkyCbzYva+KFPWqaPvvywnLjSd+WA1zgT
         /G47cFvZOQq+ZMDQDpf8czlqYE/3Tc53r6EulFys/4tzFXZWOQoQOrZPnjoh7iJN/Qc6
         KcRlA33j+uMtHldJiRzWrp9f3acUvvGIe7xhw8I39n4ux1Y6Byy10aQSnXHYEPSp7cgd
         HbtOz55crTAS8Wi+EFf0HLgAIVHDTvrVRdjJysWSMIz1HSur3ON9jXEoToUy/+6+KnID
         dgYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AB8JxZrDr3j+5hHznQEm93fBLnlVxki7YjjeKNd9+K5p3+99kMvNwQkgZwzogm67WwRHf62LNcNrZQ==
Subject: Re: Bug in vboxguest: After commit Merge tag 'char-misc-4.17-rc3'
To: Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
 linux-kernel@vger.kernel.org
References: <20180502193735.GA2444@zrhn9910b>
 <20180502200615.GB16341@kroah.com> <20180502204612.GA2089@zrhn9910b>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <2bc020fe-a298-f988-a95f-c33123d6be6c@redhat.com>
Date: Wed, 2 May 2018 23:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502204612.GA2089@zrhn9910b>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599382342256929089?=
X-GMAIL-MSGID: =?utf-8?q?1599388054224521793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/02/2018 10:46 PM, damian wrote:
> Hello Greg,
> 
> it is PATCH 3 virt: vbox: Use __get_free_pages insteas of kmalloc for DMA32 memory.

Weird. I'm currently on vacation. I will look into this first thing next Monday.

Regards,

Hans
