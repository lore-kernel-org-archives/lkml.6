Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeDDIdU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:33:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:60569 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeDDIdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:33:18 -0400
Date: Wed, 4 Apr 2018 10:33:16 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Martin van Es <martin@mrvanes.com>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Martin <bugs@mrvanes.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: input: fix battery level reporting on BT mice
In-Reply-To: <10651380.a6EbCRfp8J@minivanes>
Message-ID: <nycvar.YFH.7.76.1804041032560.15778@cbobk.fhfr.pm>
References: <20180403175220.GA148162@dtor-ws> <10651380.a6EbCRfp8J@minivanes>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018, Martin van Es wrote:

> Hi Dimitry,
> 
> I reapplied the 3 commits I had to revert earlier and applied your patch. Have 
> correct battery level reading on my BT mouse back!
> 
> /sys/class/power_supply/hid-00:1f:20:fd:cb:be-battery# grep "" *
> capacity:53
> grep: device: Is a directory
> model_name:Bluetooth Mouse M336/M337/M535
> online:1
> grep: power: Is a directory
> grep: powers: Is a directory
> present:1
> scope:Device
> status:Discharging
> grep: subsystem: Is a directory
> type:Battery
> uevent:POWER_SUPPLY_NAME=hid-00:1f:20:fd:cb:be-battery
> uevent:POWER_SUPPLY_PRESENT=1
> uevent:POWER_SUPPLY_ONLINE=1
> uevent:POWER_SUPPLY_CAPACITY=53
> uevent:POWER_SUPPLY_MODEL_NAME=Bluetooth Mouse M336/M337/M535
> uevent:POWER_SUPPLY_STATUS=Discharging
> uevent:POWER_SUPPLY_SCOPE=Device
> 
> rdesc file is attached
> 
> Thx for the effort!

Can I add your Tested-by: while applying the commit?

Thanks,

-- 
Jiri Kosina
SUSE Labs
