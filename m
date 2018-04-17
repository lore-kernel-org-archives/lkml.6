Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeDQLmj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:42:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36575 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeDQLmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:42:37 -0400
Subject: Re: [PATCH v2 0/9] Input: support for latest Lenovo thinkpads (series
 80)
To: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        "'Benjamin Tissoires'" <benjamin.tissoires@redhat.com>
Cc: "'Oliver Haessler'" <oliver@redhat.com>,
        "'Benjamin Berg'" <bberg@redhat.com>,
        "'Rob Herring'" <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "'open list:HID CORE LAYER'" <linux-input@vger.kernel.org>,
        "'lkml'" <linux-kernel@vger.kernel.org>,
        "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
 <CAO-hwJJnHPEQ+R+8qWb1Dn+otqgmbcKgiNDOyNkVBD+xdzY_zw@mail.gmail.com>
 <00f701d3d627$bcf41de0$36dc59a0$@emc.com.tw>
From: Aaron Ma <aaron.ma@canonical.com>
Openpgp: preference=signencrypt
Message-ID: <ca40347e-44cd-aa93-75ba-1bf0a63705be@canonical.com>
Date: Tue, 17 Apr 2018 19:42:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <00f701d3d627$bcf41de0$36dc59a0$@emc.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry and Benjamin:

Could you apply my patch too?

It add LEN0096 that Benjamin's patch doesn't include.

+	"LEN0096", /* X280 */

Regards,
Aaron
