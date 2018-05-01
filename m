Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeEAX25 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 19:28:57 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:45445 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeEAX2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 19:28:54 -0400
X-Google-Smtp-Source: AB8JxZrZ2rcXPoksnGdCuMDab9rezB2jPKKKJJ+EiP8z4eQl315TvnTI/UYMSv4tv8WB1uRbu/5JJA==
Date: Tue, 1 May 2018 16:28:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        ganeshgr@chelsio.com, nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next v7 1/3] vmcore: add API to collect hardware
 dump in second kernel
Message-ID: <20180501162851.0fceb210@xeon-e3>
In-Reply-To: <b6065b53c5446d98ee55e09119f6821f979418d4.1525197408.git.rahul.lakkireddy@chelsio.com>
References: <cover.1525197407.git.rahul.lakkireddy@chelsio.com>
        <b6065b53c5446d98ee55e09119f6821f979418d4.1525197408.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 May 2018 23:57:45 +0530
Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> wrote:

> +
> +int vmcore_add_device_dump(struct vmcoredd_data *data)
> +{
> +	return __vmcore_add_device_dump(data);
> +}
> +EXPORT_SYMBOL(vmcore_add_device_dump);
> +#endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP

Why the stub wrapper function? 
it does nothing.
