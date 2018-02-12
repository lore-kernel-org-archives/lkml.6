Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbeBLSrx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:47:53 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37324 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeBLSru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:47:50 -0500
X-Google-Smtp-Source: AH8x225H+IzPsGdKkfVnsPwbXo+9pBXKFgcqcqrej8j/HGET4AVDPvh0AcgJvkqsMIIQVJQNyxSAJg==
Subject: Re: [PATCH 3/3] nvme: change namespaces_mutext to namespaces_rwsem
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518440086-583-3-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <83870bcb-5d43-df08-24f1-2aa538643c1a@grimberg.me>
Date: Mon, 12 Feb 2018 20:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518440086-583-3-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks fine to me, but I really want Keith and/or Christoph to have
a look as well.
