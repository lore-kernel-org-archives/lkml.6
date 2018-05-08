Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755160AbeEHMyT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:54:19 -0400
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:36710 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754966AbeEHMyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:54:18 -0400
Date: Tue, 8 May 2018 07:54:15 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
cc: tglx@linutronix.de, arnd@arndb.de, keescook@chromium.org,
        luto@amacapital.net, longman@redhat.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, ebiederm@xmission.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
In-Reply-To: <20180507231506.4891-1-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.21.1805080753590.1849@nuc-kabylake>
References: <20180507231506.4891-1-mcgrof@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfI1KDjm9FVYwIHuATmWVzrrjDoG5QbN0vnT+BUdD2Lr4wXju/eDr8O3k2+iQzPGygOP+Nw27j0R51hfx2qsDZ4JwRqcgMny+PYJyQ5+Ach16QaLlKsqh
 rxdgilnalQJoOAUVTVVJAVFVkRuh6IQjEbeOn2QmpwIu902WCVVIMt9RC3k+tOGwaWI901plw3q7QN86T01p5viKV+hQedJ3ocURYSiLAB7Hf2y1JAz9L/Cl
 gFpkD5RlT7BG7buNBlMP/3DLvwFWGg6BJ3RGIicui2HBxUDVKi551hCtjx+GI6PNTmmzHxf3LWiM7FsS+OGMbJ0l5psIpNkzeA9UIN6BMKvm5WQdRzpmMF+1
 3WzsRNi21O/hHm0wbh+agGixQ6aVqeloy6EccrIQGkgnBaeEjGx5Cvnc9HpdHBBIO5W5s2JiJEK0L/OVyQmFO59C9g2GBUP01+IVu77KCI3vfqGGJJgs50l3
 Xrp7SjtozZDP4O+A8QCMPJynz+yYWOK6Lx0E6Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2018, Luis R. Rodriguez wrote:

> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over it use.

Acked-by: Christoph Lameter <cl@linux.com>
