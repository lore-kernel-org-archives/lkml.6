Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeCLNxL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:53:11 -0400
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:45490 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751229AbeCLNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:53:09 -0400
Date: Mon, 12 Mar 2018 08:53:07 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Roman Lakeev <sunnyddayss@gmail.com>
cc: Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c: remove duplicated check of colour_next
In-Reply-To: <877eqilr71.fsf@gmail.com>
Message-ID: <alpine.DEB.2.20.1803120852490.1262@nuc-kabylake>
References: <877eqilr71.fsf@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfJZqF4abQpj8on0CN944w3xNGUApXInZeh2edIgL35HyfyUaGuyGuwDkbv1MOtV92yJPCctjo+6e/6nD+YZh42Kbi/gLzMcoWzC3Zzk6FEj14rTjMDvI
 srUrrdcbJ2YMJsq2rzzDNJxNYKDvMsGPglWmMACS68xYiYWNfJ36Y9gziY9qV6pYYn7gDQ935OPS/NDv1xBvsZPYmzSWm1JpcXDf+oxGRcgXFDyXx273c7CQ
 evcgCxaQAP8R8yUNV9Md5tLUtbOWiQhL2Y1oxE2FRZisFEaKEdpe17mQk3j5xaL2YcQ4c9DSKbP0NXxa+Bv/fEGWRyM+U7voT99tmNd7Rnrt3oioSq+hqJUz
 PKB7qqaX
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Christoph Lameter <cl@linux.com>
