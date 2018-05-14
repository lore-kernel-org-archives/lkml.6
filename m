Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeENJuH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:50:07 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:38025 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeENJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:50:05 -0400
X-Google-Smtp-Source: AB8JxZo42gfvgstHITDHD3pZJc9tiB/PrtHj0uroKxgU+Y/1jJ6piYkveHDempuTNul8ludheHx+7w==
Subject: Re: [PATCH v2] ipvlan: flush arp table when mac address changed
To: liuqifa@huawei.com, davem@davemloft.net, dsahern@gmail.com,
        maheshb@google.com, weiyongjun1@huawei.com, maowenan@huawei.com,
        dingtianhong@huawei.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180514092256.10940-1-liuqifa@huawei.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <cb228cce-be10-31dc-f4bf-acefe3f3d0e1@cogentembedded.com>
Date: Mon, 14 May 2018 12:50:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514092256.10940-1-liuqifa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 5/14/2018 12:22 PM, liuqifa@huawei.com wrote:

> From: Keefe Liu <liuqifa@huawei.com>
> 
> When master device's mac has been changed, the
> commit <32c10bbfe914> "ipvlan: always use the current L2
> addr of the master" makes the IPVlan devices's mac changed

commit 32c10bbfe914 ("ipvlan: always use the current L2
addr of the master").

> also, but it doesn't flush the IPVlan's arp table.
> 
> Signed-off-by: Keefe Liu <liuqifa@huawei.com>
[...]

MBR, Sergei
