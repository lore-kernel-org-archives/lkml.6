Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDENzC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:55:02 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:50936 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeDENzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:55:01 -0400
X-Google-Smtp-Source: AIpwx4+f86IQGDZTcG5blY1zm//5CEY4mg5jf2ziEvq9yfRpMw8tZ916tyFuIwfJWxt0LTA46WESSA==
Date: Thu, 5 Apr 2018 15:54:57 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/3] drm: Add helper iterator functions to iterate over
 plane damage.
Message-ID: <20180405135457.GZ3881@phenom.ffwll.local>
Mail-Followup-To: Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-3-git-send-email-drawat@vmware.com>
 <20180405075205.GQ3881@phenom.ffwll.local>
 <bdf67c61-3f4f-f321-9125-dc608c05c9b3@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdf67c61-3f4f-f321-9125-dc608c05c9b3@vmware.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 10:51:42AM +0200, Thomas Hellstrom wrote:
> On 04/05/2018 09:52 AM, Daniel Vetter wrote:
> > 
> > TYPE_PLANE I have no idea who needs that. I suggest we just drop it.
> 
> I'm assuming CRTC plane coordinates here. They are used for uploading
> contents of hardware planes. Like, in the simplest case, cursor images.

Hm, I guess I'd need to see how it's being used, since I'm neither
following the intent of the original code nor your explanation here I
think ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
