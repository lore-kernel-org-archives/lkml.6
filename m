Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeBHOEV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:04:21 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:39317 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeBHOEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:04:20 -0500
X-Google-Smtp-Source: AH8x224ADeSRrKuo43j9KltSh6RV6CB+iWIN0qqw/VXmcHRlu/XpWYhl2vywefGcenEefTdK7ao+kA==
Message-ID: <1518098657.2670.3.camel@gmail.com>
Subject: Re: [PATCH 1/2] trace-cmd: Fix the detection for swig
From: Vladislav Valtchev <vladislav.valtchev@gmail.com>
To: Zamir SUN <sztsian@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: johannes.berg@intel.com, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, zsun@redhat.com
Date: Thu, 08 Feb 2018 16:04:17 +0200
In-Reply-To: <a1c2c3f6-8d69-227d-51d4-1c40c53e0645@gmail.com>
References: <20180204032014.6962-1-sztsian@gmail.com>
         <20180204032014.6962-2-sztsian@gmail.com>
         <20180206181807.2d35393e@gandalf.local.home>
         <df980185-aa29-f65b-d5b0-f42d85a66a51@gmail.com>
         <1518024315.3742.16.camel@gmail.com>
         <a1c2c3f6-8d69-227d-51d4-1c40c53e0645@gmail.com>
Organization: VMware
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-08 at 20:05 +0800, Zamir SUN wrote:
> 
> Hi Vladislav,
> 
> Thanks for the URL. I tried to build from your make8 branch, it works
> fine. I must made some copy-paste mistake yesterday.
> 
> Sorry for the noise.
> 
> Thanks.

No problem, Zamir.
I'm happy that it works.

The series has been merged in the master branch by Steven now.

Anyway, I think your patch 2/2 is still necessary: thanks for it!

Vlad

-- 
Vladislav Valtchev
VMware Open Source Technology Center
