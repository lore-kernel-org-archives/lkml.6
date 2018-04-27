Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758431AbeD0N0O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:26:14 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:39924 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeD0N0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:26:10 -0400
X-Google-Smtp-Source: AB8JxZpZTLdKoueH4/Mwr7vg2SwR01NJAsOTblScSGdpsYTAzblbdeDpaP4TrDsTHELjCUkt5scpFA==
Date: Fri, 27 Apr 2018 06:26:07 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: YueHaibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp_pch: use helpers function for converting between ns
 and timespec
Message-ID: <20180427132607.hyvrqol3mprnrpsy@localhost>
References: <20180427073618.12036-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427073618.12036-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 03:36:18PM +0800, YueHaibing wrote:
> use ns_to_timespec64() and timespec64_to_ns() instead of open coding

Acked-by: Richard Cochran <richardcochran@gmail.com>
