Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbeBLSrO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:47:14 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:40023 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbeBLSqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:46:13 -0500
X-Google-Smtp-Source: AH8x227WtY1T+HEnAy6KrJnuarRNolDWj/0sy//bHzyQSU2hwGa4rEqb8WUFk5VO0Whm2ruxsJMD3w==
Subject: Re: [PATCH 1/3] nvme: fix the dangerous reference of namespaces list
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4837ee1c-da12-e315-5c46-22d05aa66bee@grimberg.me>
Date: Mon, 12 Feb 2018 20:46:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
