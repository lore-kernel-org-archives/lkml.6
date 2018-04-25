Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeDYIve (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:51:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:39517 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeDYIv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:51:29 -0400
Date: Wed, 25 Apr 2018 10:51:27 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
cc: benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: wacom: Release device resource data obtained by
 devres_alloc()
In-Reply-To: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
Message-ID: <nycvar.YFH.7.76.1804251051200.28129@cbobk.fhfr.pm>
References: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Arvind Yadav wrote:

> Free device resource data, if __wacom_devm_sysfs_create_group
> is not successful.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
