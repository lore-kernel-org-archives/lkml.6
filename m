Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeEVPoX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:44:23 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:58426 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751291AbeEVPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:44:21 -0400
Subject: Re: [PATCH] net: vxge: fix spelling mistake in macro
 VXGE_HW_ERR_PRIVILAGED_OPEARATION
To: Colin King <colin.king@canonical.com>, Jon Mason <jdmason@kudzu.us>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180522153616.13980-1-colin.king@canonical.com>
From: Edward Cree <ecree@solarflare.com>
Message-ID: <11586972-0dbb-f86c-396c-ac863e10f18f@solarflare.com>
Date: Tue, 22 May 2018 16:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180522153616.13980-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-MDID: 1527003860-Wyis2iLJbgP6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/18 16:36, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Rename VXGE_HW_ERR_PRIVILAGED_OPEARATION to VXGE_HW_ERR_PRIVILAGED_OPERATION
> to fix spelling mistake.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
"Privilaged" doesn't look right either, maybe fix both at once?
 -> VXGE_HW_PRIVILEGED_OPERATION

-Ed
