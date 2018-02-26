Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBZTmU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:42:20 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:44236 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbeBZTmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:42:18 -0500
X-Google-Smtp-Source: AH8x227i0bVKm8Q0j1/vWuYx8HWhax4RdpAG6r5YrKEG4lCrBEauyZqBYJcM9d0Oer7JFaWIzh78/g==
Subject: Re: [PATCH 0/6] of: remove kbasename() from core
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1519611750-22355-1-git-send-email-frowand.list@gmail.com>
 <CAMuHMdUj63OQnJWz=Q57dbc1XKOnq+_et5-E_4yQjTZt+c++GQ@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <48509f67-9e94-ebe6-746b-c1262ea143b0@gmail.com>
Date: Mon, 26 Feb 2018 11:42:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUj63OQnJWz=Q57dbc1XKOnq+_et5-E_4yQjTZt+c++GQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/18 01:03, Geert Uytterhoeven wrote:
> Hi Frank,
> 
> On Mon, Feb 26, 2018 at 3:22 AM,  <frowand.list@gmail.com> wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Struct device_node full_name no longer includes the full path
>> name.
> 
> Is this now also true on systems with real Open Firmware?

Thanks, good point.  I can not remove the kbasename() calls.

Will re-spin, as a much smaller patch to deal with the
overlay issues.

-Frank
