Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeDSQWk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:22:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33023 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbeDSQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:22:37 -0400
X-Google-Smtp-Source: AB8JxZo4K8eF32weGSSY0gEU71sY/CT/0PfaCjBo8g5xjNdzqFmwdCd2lXPVFdCNEB5D5VGROwc9pA==
Subject: Re: [PATCH 02/61] ata: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-3-wsa+renesas@sang-engineering.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <c486565a-d3f3-2ce0-eca2-3aa60a6c99b2@cogentembedded.com>
Date: Thu, 19 Apr 2018 19:22:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/19/2018 05:05 PM, Wolfram Sang wrote:

> We should get drvdata from struct device directly. Going via

  Note that the name of the field in the 'struct device' is driver_data,
not drvdata. Otherwise the patch looks good.

> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[...]

MBR, Sergei
