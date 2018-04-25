Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeDYJXI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:23:08 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36951 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeDYJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:23:05 -0400
X-Google-Smtp-Source: AIpwx4/yTHm3lP7HpZEMf2MvoBNSqZKULvrFHgKh/TndiD9jcJUmsaxrYL1jDo9TGAg56dQdUVQaAg==
Subject: Re: [net-next v3] ipv6: sr: Compute flowlabel for outer IPv6 header
 of seg6 encap mode
To: Ahmed Abdelsalam <amsalam20@gmail.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1524594196-12383-1-git-send-email-amsalam20@gmail.com>
From: David Lebrun <dav.lebrun@gmail.com>
Message-ID: <d31a2f8d-5074-2b04-4d0e-e67199f985cc@gmail.com>
Date: Wed, 25 Apr 2018 10:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1524594196-12383-1-git-send-email-amsalam20@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 07:23 PM, Ahmed Abdelsalam wrote:
> 
> Signed-off-by: Ahmed Abdelsalam <amsalam20@gmail.com>

Acked-by: David Lebrun <dlebrun@google.com>
