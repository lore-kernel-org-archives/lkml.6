Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeBFNsD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:48:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:51813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbeBFNrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 08:47:53 -0500
Message-ID: <1517924861.25841.33.camel@gmx.de>
Subject: Re: [PATCH BUGFIX 1/1] block, bfq: add requeue-request hook
From: Mike Galbraith <efault@gmx.de>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "'Paolo Valente' via bfq-iosched"
        <bfq-iosched@googlegroups.com>,
        Alban Browaeys <alban.browaeys@gmail.com>, ming.lei@redhat.com,
        ivan@ludios.org, 169364@studenti.unimore.it,
        Serena Ziviani <ziviani.serena@gmail.com>
Date: Tue, 06 Feb 2018 14:47:41 +0100
In-Reply-To: <BE442D49-D280-4B35-89ED-43C729263F2A@linaro.org>
References: <20180205190510.5499-1-paolo.valente@linaro.org>
         <20180205190510.5499-2-paolo.valente@linaro.org>
         <ee76e49c0d1ceab07c20e9d27e2fdc46@natalenko.name>
         <1517903761.9843.12.camel@gmx.de>
         <899B68CC-5955-4418-8BFF-DC55A743A61B@linaro.org>
         <1517918234.25841.31.camel@gmx.de>
         <BE442D49-D280-4B35-89ED-43C729263F2A@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:6TJRh3tQCISPsj78PbSDz8k/XzSE8c+Wa9uGtDKV4vAibYaoQpJ
 7duKorXgBJn1pQ9B1PKSYzhaNGaW4Bp8PtG9S50KejlTtxvxP30hiRPPb1JKNNPjye9OiuB
 +zcSYOGoB64eBLY/bsRsk/tuwJ2BcURswy7rRM5U7l+7QkDidYFWzkNF4HGJflkjlHj/jRk
 mo4kIOPY3An1HEHPto8Xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eMNyWfpFXIc=:onkIDyuD5ZBP/i5Z3BR2oO
 +mWBucM4vpmYOYtlK78y9eKPwOY9XSM4NdbHfUq3IWtHkAuaeA62QcxqP0cUp07rGrFNXiNso
 0LfZPDtnJyDg4Swp/nwHUXLxwyK/hKb6p5U0kjR60Ob/WGBvUrayQA4CtDN7hsDt5owa6KdAw
 CTRQC442peTvX9rsHYi7R3KBo+jHX9f6j9WTxbcIc15S3ZG3iUCz8OWB0UrLD1eRbnFyxpOHA
 jTliGMyeZ2TgMS5T0mFlGgcvvRUs5gQA4pask9GP613Ydo9GUHxNbx5bLoOMxg3Vw+h7TLxQG
 qpcRe9v5CaMZgC9d4AeeyvWnQk6OcyQ9bxYzGopdV6XICl7wARGEQP+A8SAv6vUNU+443BHz7
 QkT/WpWXQ+03Z7Z4S84h7HU7iTwt4YJKSvQxNbhOqN4okhm0jaISL6muO7Z+DzQQ1Et+edsZN
 5zeWVCEJmmZCGGDi/kCOuRxFHkZmbc/t4olW+9r8L31mFu1k6RXqSIT/z6yk9WDrQ4QnOjKgI
 ehWlFvICoPPp7GQqjhp417gG/i7qMqTf3S4cYE8d7p7+eBo05W+yPaKQE5F6Gnofb9/b/oj3x
 iV9Iz0AVDIKeYpcaJ25+iVBkDprgOXoRj2Ed5sUQjhVpksURWnOLdnn1pMRv4HGCyXVVGm/Vt
 /Fe3sqRXI2v92fV7bqow3Ing3YCH09Vteq4QzGdwYM8bsaKD7WnEJXEWYwN7OTLuozEn3X++O
 l/bDazOe8GvKayZTIN5CaP+Ija51YbAGGBKXZ3u755P61YcwgvpWHzRad+fSHCWGAVdfC4zQd
 n4b59+Goei8IxK4Nq3LtdEzIeY5+bvaKuk1uqz59DEyiHQ2XyI=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-06 at 13:26 +0100, Paolo Valente wrote:
> 
> ok, right in the middle of bfq this time ... Was this the first OOPS in your kernel log?

Yeah.
