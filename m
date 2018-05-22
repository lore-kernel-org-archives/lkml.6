Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeEVSVC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:21:02 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43810 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEVSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:20:58 -0400
X-Google-Smtp-Source: AB8JxZrfyPweSgn5uNPA5XkiYKp6u28S+UrZUMZGARa+/EGTOvOr2JFXZVbEvDsN5rhbRMrio0FOFQ==
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com>
 <20180521135003.32459-2-mr.nuke.me@gmail.com>
 <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
 <53d0ba88-6929-a7cf-6c3e-4ca389f7249a@gmail.com>
 <CAJZ5v0hOC5P79OGAfutLcWzRuh+r9wrf2i3LOVs5VfGqbmoitA@mail.gmail.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <27199a35-922b-c57d-3c50-e9954a5d80a0@gmail.com>
Date: Tue, 22 May 2018 13:20:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hOC5P79OGAfutLcWzRuh+r9wrf2i3LOVs5VfGqbmoitA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 01:13 PM, Rafael J. Wysocki wrote:
(snip)
> Of course, you are free to have a differing opinion and I don't have
> to convince you about my point.  You need to convince me about your
> point to get the patch in through my tree, which you haven't done so
> far.

My point is that crossing your arms and saying "impress me" doesn't give 
me a good idea of how you'd like to see the problem resolved.

Alex
