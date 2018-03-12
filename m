Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeCLPsC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:48:02 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:41959 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932566AbeCLPsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:48:00 -0400
X-Google-Smtp-Source: AG47ELs5nJrZ6bzOik7mVChk75ve3zPFwbaXyQB9laxawhIpu82+4BN55tfYeyM99ZU2cD00eVqzU/FrOd0zh37sQpo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180312075938.7uo7vhzdyzhtzsph@madcap2.tricolour.ca>
References: <cover.1518603831.git.rgb@redhat.com> <1c5184985e422774329484153b0147c2861e91a7.1518603831.git.rgb@redhat.com>
 <CAHC9VhQAiQdCeayzYY5Nr0rqJu0q0AbbM2ovqAe7hYNZGOwyxA@mail.gmail.com> <20180312075938.7uo7vhzdyzhtzsph@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Mar 2018 11:47:58 -0400
Message-ID: <CAHC9VhSkd==VKfnBLpVra1V8FNXD-V9HZv07UyFU=EZLaQ5CdQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak21 4/4] audit: add parent of refused symlink to audit_names
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 3:59 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-03-08 19:50, Paul Moore wrote:

...

>> (Point #2 is why I didn't merge patch 3/4, just include it in this
>> revised patch)
>
> On reviewing this, I'm not totally convinced the parent record is
> necessary to fully understand what happenned since there is a CWD
> record.  I left 3 and 4 as seperate patches in case it is found that
> only 3 is necessary.

You need to figure this out and decide what is necessary.

-- 
paul moore
www.paul-moore.com
