Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965034AbeEIPbh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:31:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56726 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935397AbeEIPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:31:36 -0400
Subject: Re: linux-next: Tree for May 9 (mlx5)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
References: <20180509212133.41a59f2f@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <826ab15b-f2bc-0c5d-8d5e-6466badcd3e0@infradead.org>
Date: Wed, 9 May 2018 08:31:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509212133.41a59f2f@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2018 04:21 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180508:
> 

on x86_64:
# CONFIG_SMP is not set

In file included from ../drivers/net/ethernet/mellanox/mlx5/core/main.c:43:0:
../include/linux/mlx5/driver.h: In function 'mlx5_get_vector_affinity_hint':
../include/linux/mlx5/driver.h:1299:13: error: 'struct irq_desc' has no member named 'affinity_hint'
  return desc->affinity_hint;
             ^


-- 
~Randy
