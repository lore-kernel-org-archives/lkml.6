Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeB0WwF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:52:05 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35533 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeB0WwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:52:02 -0500
X-Google-Smtp-Source: AG47ELvWNymfwTOxl7xN/IfCFfs/BIbJfo/a0Hd/eOHLta1EthjQG7mXzn15MCKFWCm2lhD2pg3hyw==
Subject: Re: [PATCH] nbd: fix return value in error handling path
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Josef Bacik <jbacik@fb.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <20180212171450.GA31668@embeddedgus>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e9fb8864-a36a-7ed0-ed86-0a1ae8ae92bd@kernel.dk>
Date: Tue, 27 Feb 2018 15:51:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180212171450.GA31668@embeddedgus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/18 10:14 AM, Gustavo A. R. Silva wrote:
> It seems that the proper value to return in this particular case is the
> one contained into variable new_index instead of ret.

Thanks, applied.

-- 
Jens Axboe
