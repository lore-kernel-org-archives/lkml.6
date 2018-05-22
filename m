Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeEVAw3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:52:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751202AbeEVAwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:52:25 -0400
Subject: Re: [PATCH 00/33] use match_string() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <CAHp75VdNk-U=6Mhp-Kg_C0maM92dw595By_MDm-_O6952Q1J2Q@mail.gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <3d1afe8e-8b86-4be8-0fbc-33f5d9eb6121@huawei.com>
Date: Tue, 22 May 2018 08:52:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdNk-U=6Mhp-Kg_C0maM92dw595By_MDm-_O6952Q1J2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018/5/22 6:27, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> Andy introduce helper function match_string() which can be used to return
>> the index of array for a matching string. so we can use it in many places
>> intead of open coded variant.
> 
> You forgot to Cc that Andy.

Yeah, I just forgot it when send them out.
> 
> For the patches I didn't comment, LGTM
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks, and I will drop the ones you already sent out, and make a v2 as your comment!

Thanks
Yisheng
