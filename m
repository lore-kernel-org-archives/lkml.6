Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeDACHe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 22:07:34 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49650 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbeDACHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 22:07:33 -0400
Date: Sat, 31 Mar 2018 22:07:30 -0400 (EDT)
Message-Id: <20180331.220730.1991017148197107974.davem@davemloft.net>
To: Vadim.Lomovtsev@caviumnetworks.com
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dnelson@redhat.com,
        ynorov@caviumnetworks.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH v2 0/7] net: thunderx: implement DMAC filtering support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
        <20180330115953.17154-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Fri, 30 Mar 2018 04:59:46 -0700

> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> By default CN88XX BGX accepts all incoming multicast and broadcast
> packets and filtering is disabled. The nic driver doesn't provide
> an ability to change such behaviour.
> 
> This series is to implement DMAC filtering management for CN88XX
> nic driver allowing user to enable/disable filtering and configure
> specific MAC addresses to filter traffic.
> 
> Changes from v1:
> build issues:
>  - update code in order to address compiler warnings;
> checkpatch.pl reported issues:
>  - update code in order to fit 80 symbols length;
>  - update commit descriptions in order to fit 80 symbols length;

Series applied.
