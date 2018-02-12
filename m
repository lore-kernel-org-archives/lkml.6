Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932320AbeBLSqW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:46:22 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:53928 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932210AbeBLSqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:46:19 -0500
X-Google-Smtp-Source: AH8x226kFvMBFgDqmVLxNocrM3UVQEqVSXlE/3pT8toBdIQFYqk0jgVWrm2OZ0usIEoERJQ1m5FarA==
Subject: Re: [PATCH 2/3] nvme: fix the deadlock in nvme_update_formats
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518440086-583-2-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <16c23a0c-666c-802e-2b4e-c6a6da6f016b@grimberg.me>
Date: Mon, 12 Feb 2018 20:46:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518440086-583-2-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
