Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965851AbeEJOVk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:21:40 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:39322 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935628AbeEJOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:21:37 -0400
X-Google-Smtp-Source: AB8JxZoLsOsq521lVcQEf/CF7dB/y7UCWYrCIN+UGktd3cElzqpaLzSNxK16m/Omp/STLdO7c2e5Yw==
Subject: Re: [PATCH] mtip32xx: Fix an error handling path in
 'mtip_pci_probe()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ming.lei@redhat.com, martin.petersen@oracle.com, sagi@grimberg.me,
        chris.gekas@gmail.com, bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180510072731.19956-1-christophe.jaillet@wanadoo.fr>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <1c91e861-9f38-4c77-d7ac-1a1499932c1a@kernel.dk>
Date: Thu, 10 May 2018 08:21:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180510072731.19956-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/18 1:27 AM, Christophe JAILLET wrote:
> Branch to the right label in the error handling path in order to keep it
> logical.

Looks good, applied.

-- 
Jens Axboe
