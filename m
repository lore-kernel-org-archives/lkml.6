Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755574AbeDZMEg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:04:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46669 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754559AbeDZMEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:04:31 -0400
X-Google-Smtp-Source: AB8JxZqQ7Bz0bL9Nt5Kd2zf71CgNMhSH982ywXoW2wBSGDXRdwcQNHcL/LYTx8rS3PNYUeOrOpnGmQ==
Subject: Re: [PATCH] connector: add parent pid and tgid to coredump and exit
 events
To: Jesper Derehag <jderehag@hotmail.com>,
        David Miller <davem@davemloft.net>,
        "zbr@ioremap.net" <zbr@ioremap.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>,
        "matt.helsley@gmail.com" <matt.helsley@gmail.com>
References: <20180329141247.20943-1-sstrogin@cisco.com>
 <20180330.125921.653839794312978457.davem@davemloft.net>
 <7d976488-6375-b3a8-e9d7-dc86b4c51b86@cisco.com>
 <DB6P190MB0389513E240BD8ECEE575DB4DDBB0@DB6P190MB0389.EURP190.PROD.OUTLOOK.COM>
From: Stefan Strogin <stefan.strogin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.strogin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <32f14672-5715-3e21-ba85-b27dc8d2c6b0@gmail.com>
Date: Thu, 26 Apr 2018 15:04:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <DB6P190MB0389513E240BD8ECEE575DB4DDBB0@DB6P190MB0389.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Evgeniy,

Sorry to bother you, but could you please comment about the UAPI change and the patch?

Thanks, Jesper.

--
Stefan

On 05/04/18 12:07, Jesper Derehag wrote:
> Unless David comes back with something I have (also) missed regarding uapi breakage, this looks good to me.
> 
> /Jesper
> 
> ________________________________________
> Från: Stefan Strogin <sstrogin@cisco.com>
> Skickat: den 2 april 2018 17:18
> Till: David Miller
> Kopia: zbr@ioremap.net; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; xe-linux-external@cisco.com; jderehag@hotmail.com; matt.helsley@gmail.com; minipli@googlemail.com
> Ämne: Re: [PATCH] connector: add parent pid and tgid to coredump and exit events
> 
> Hi David,
> 
> I don't see how it breaks UAPI. The point is that structures
> coredump_proc_event and exit_proc_event are members of *union*
> event_data, thus position of the existing data in the structure is
> unchanged. Furthermore, this change won't increase size of struct
> proc_event, because comm_proc_event (also a member of event_data) is
> of bigger size than the changed structures.
> 
> If I'm wrong, could you please explain what exactly will the change
> break in UAPI?
> 
> 
> On 30/03/18 19:59, David Miller wrote:
>> From: Stefan Strogin <sstrogin@cisco.com>
>> Date: Thu, 29 Mar 2018 17:12:47 +0300
>>
>>> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
>>> index 68ff25414700..db210625cee8 100644
>>> --- a/include/uapi/linux/cn_proc.h
>>> +++ b/include/uapi/linux/cn_proc.h
>>> @@ -116,12 +116,16 @@ struct proc_event {
>>>              struct coredump_proc_event {
>>>                      __kernel_pid_t process_pid;
>>>                      __kernel_pid_t process_tgid;
>>> +                    __kernel_pid_t parent_pid;
>>> +                    __kernel_pid_t parent_tgid;
>>>              } coredump;
>>>
>>>              struct exit_proc_event {
>>>                      __kernel_pid_t process_pid;
>>>                      __kernel_pid_t process_tgid;
>>>                      __u32 exit_code, exit_signal;
>>> +                    __kernel_pid_t parent_pid;
>>> +                    __kernel_pid_t parent_tgid;
>>>              } exit;
>>>
>>>      } event_data;
>>
>> I don't think you can add these members without breaking UAPI.
>>
> 
