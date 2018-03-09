Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeCIVQI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:16:08 -0500
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:12767
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932157AbeCIVQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:16:07 -0500
X-HalOne-Cookie: 989dae9f8e42d9e5662edcb4a4f6f522ca91702e
X-HalOne-ID: d46a574b-23dc-11e8-bb64-d0431ea8a290
Subject: Re: [PATCH v3] input: bcm5974 - Add driver for Apple Magic Trackpad 2
To: Stephan Mueller <smueller@chronox.de>, Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, marek.wyborski@emwesoft.com,
        linux-kernel@vger.kernel.org
References: <40764439.8xGR6LbaWR@positron.chronox.de>
 <2305311.UGlXl2onVb@positron.chronox.de>
 <1566223.3I8hjEaRec@tauon.chronox.de> <2373130.0OS7LSYeBT@tauon.chronox.de>
From: Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <73c3d354-8aa8-e0c2-c4c4-658a65154394@bitmath.org>
Date: Fri, 9 Mar 2018 22:00:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2373130.0OS7LSYeBT@tauon.chronox.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

>> I would like to have Touchpad 2 properly supported.
You will find proper prior support for Magic Trackpads in 
drivers/hid/hid-magicmouse.c.

Henrik
