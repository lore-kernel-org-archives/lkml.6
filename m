Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932326AbeCKTtl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:49:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51365 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932161AbeCKTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:49:40 -0400
X-Google-Smtp-Source: AG47ELuAWDPnYGM1/mkG3Z2t3/YNN0EZ81j6qeFL6mdkKzP7rdaKee+EuOidVEq61SHOaAcYvG4Ksg==
Date: Sun, 11 Mar 2018 12:49:37 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Roman Lakeev <sunnyddayss@gmail.com>
cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c: remove duplicated check of colour_next
In-Reply-To: <877eqilr71.fsf@gmail.com>
Message-ID: <alpine.DEB.2.20.1803111249180.155711@chino.kir.corp.google.com>
References: <877eqilr71.fsf@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Mar 2018, Roman Lakeev wrote:

> Sorry for strange message in previous mail.
> 
> remove check that offset greater than cachep->colour
> bacause this is already checked in previous lines
> 
> Signed-off-by: Roman Lakeev <sunnyddayss@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
