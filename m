Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeBHLCf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 06:02:35 -0500
Received: from nbd.name ([46.4.11.11]:53062 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbeBHLCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 06:02:33 -0500
Subject: Re: [PATCH] ath9k: turn on btcoex_enable as default
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, kvalo@codeaurora.org
Cc: ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180208052801.15670-1-kai.heng.feng@canonical.com>
From: Felix Fietkau <nbd@nbd.name>
Message-ID: <56d650e6-d26f-087c-4e86-2e5d4e859414@nbd.name>
Date: Thu, 8 Feb 2018 12:02:29 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180208052801.15670-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-08 06:28, Kai-Heng Feng wrote:
> Without btcoex_enable, WiFi activies make both WiFi and Bluetooth
> unstable if there's a bluetooth connection.
> 
> Enable this option when bt_ant_diversity is disabled.
> 
> BugLink: https://bugs.launchpad.net/bugs/1746164
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
I think this might cause regressions on devices that don't have
bluetooth. This probably either needs more EEPROM checks, or something
to selectively enable it only on affected platforms.

- Felix
