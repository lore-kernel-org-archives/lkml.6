Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966530AbeBPM3B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:29:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:50083 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966413AbeBPM3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:29:00 -0500
Date: Fri, 16 Feb 2018 13:28:57 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Guus Sliepen <guus@sliepen.org>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: corsair: Add support for the GLAIVE RGB gaming
 mouse
In-Reply-To: <20180210171212.7988-1-guus@sliepen.org>
Message-ID: <nycvar.YFH.7.76.1802161328460.13621@cbobk.fhfr.pm>
References: <20180210171212.7988-1-guus@sliepen.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Feb 2018, Guus Sliepen wrote:

> This mouse sold by Corsair as the GLAIVE RGB gaming mouse has the same
> problem with its HID reports as the Scimitar PRO RGB, so reuse the
> same fix for the GLAIVE RGB.

Applied to for-4.16/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
