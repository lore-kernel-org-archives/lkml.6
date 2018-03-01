Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030442AbeCAMfl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:35:41 -0500
Received: from s3.sipsolutions.net ([144.76.63.242]:55576 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030328AbeCAMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:35:39 -0500
Message-ID: <1519907734.2292.9.camel@sipsolutions.net>
Subject: Re: KASAN: use-after-free Read in mac80211_hwsim_del_radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>,
        syzbot <syzbot+70ce058e01259de7bb1d@syzkaller.appspotmail.com>,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Date: Thu, 01 Mar 2018 13:35:34 +0100
In-Reply-To: <dca7b0bb-f29f-006a-5432-e875b9da7ffe@uni-rostock.de>
References: <001a113ecf342db684056655e097@google.com>
         <1519896638.2292.7.camel@sipsolutions.net>
         <dca7b0bb-f29f-006a-5432-e875b9da7ffe@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-01 at 13:32 +0100, Benjamin Beichler wrote:
> 
> Could you give me a link to or forward the original email ? I googled
> "KASAN: use-after-free Read in mac80211_hwsim_del_radio", but only your
> answer (without the logs) appears. I try to have a look then in the next
> few days.
> 
Yeah oddly it didn't appear on the list (yet?)

I'll fwd to you.

johannes
