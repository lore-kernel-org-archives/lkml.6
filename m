Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeENITi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:19:38 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34168 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeENITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:19:30 -0400
X-Google-Smtp-Source: AB8JxZprmOAM6cmkxXZp+OEFOPbDvyJx+i+GlACKcclyc8abvIWjiwKCKS8dfoRJVsG8gBCMvUL9g5iHuyScuoaxR5k=
MIME-Version: 1.0
In-Reply-To: <ca40347e-44cd-aa93-75ba-1bf0a63705be@canonical.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
 <CAO-hwJJnHPEQ+R+8qWb1Dn+otqgmbcKgiNDOyNkVBD+xdzY_zw@mail.gmail.com>
 <00f701d3d627$bcf41de0$36dc59a0$@emc.com.tw> <ca40347e-44cd-aa93-75ba-1bf0a63705be@canonical.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 14 May 2018 10:19:29 +0200
Message-ID: <CAO-hwJ+2NoqZWLMzThJWZm55PAJ41ZxpCU3-pEHOxyWzqrLSDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Input: support for latest Lenovo thinkpads (series 80)
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        Oliver Haessler <oliver@redhat.com>, Benjamin Berg <bberg@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Aaron Ma <aaron.ma@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

This is your monthly reminder of the Lenov 80 pending series :)
Could you consider taking this series and Aaron's patch?

Cheers,
Benjamin

On Tue, Apr 17, 2018 at 1:42 PM, Aaron Ma <aaron.ma@canonical.com> wrote:
> Hi Dmitry and Benjamin:
>
> Could you apply my patch too?
>
> It add LEN0096 that Benjamin's patch doesn't include.
>
> +       "LEN0096", /* X280 */
>
> Regards,
> Aaron
