Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbeCKPPm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:15:42 -0400
Received: from mout.web.de ([212.227.17.12]:35019 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932118AbeCKPPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:15:40 -0400
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/9] UML vector network driver: Adjustments for three function
 implementations
Message-ID: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:15:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:iq+utSECWgNHzLrNq1y9R46ivSzL723vpPBlIg15O2Q9hW/JAgH
 +dsQTvbJrw/Au1RWTBDkoqPEqM9hohNS4913lVv/39Jw5PzEQoS91ZP9EMxG5uapSYdhmiA
 IBWwD85s6LwJSVNDzy24d77N4KyYIdm3tXCwX7YoUWnatFhRbQazo0B+t+sEi8rWOzjeuRH
 nNwDReKkQnAPeJ2yY6aEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9bWW00RnfSA=:IPnwAHKZP7BhIghqwA+M3p
 YqofJlGcZla8KemyrP7kRo3C/AhDWhVL03+6i9m4SvsY/9PrcSRna2k+nN8kjtbF5mTm01qIT
 XWK2kgGmSzfE+aeuGjkDvNUPmDMjFC/NGrXU9qS9qZtntGzYtEo/j8vCO4D2ipaUc1ZMuO31W
 t+CCzf8EC2DMOJaiP1hKERj2BICLYlLt/nxNDHlPul80i7SfnshtVXkHaHarsPhJp3SO0Q8hv
 1XMrU76u0GpuuW4y1TcMy7OC7U5QQk4Cf5aBTpoUyhbpxZT+73oyUlx4vEKUe/uCjFqcT8YAs
 0jcMMQuz/hvRP3a8rbP9LtufvAJn1klsxsqQXkCiA0xl2Dg168LDXUqnJ6sjICEYySIpQvzVP
 vci53D0M6TwNP3l76jP4XJUuB2fqeHSJg7j0xhTRXLH5uP0qPdhCCCEZuIRqo2FMntOmtLXJR
 mC8Z7BhDB6r3MWBx14VXLmOx2tDz+3BWA+/Kow1N89UoS5Q7dE5ZSoPdKLFR3PtdrM07rP7Sw
 Dc0O0SZby2Ao8jJbc3q6QD3sSLPyJsZb4ixblmemDqf/o8UyuGBsorP/R4pIFug8bw0OS+JQQ
 vEq92MGiIyUw9pwCYn9J0JnJeJgNUJ5wZmiEvpKfdz9MPbi7rlbnxWHh1wmZ/NRx+ensXUk26
 MjW5V9qvkVSpI2yokOPsSRkKdIhA1/rkYNH8tG45T0drwImrMqroeJxwzzoXOpT9lUIuHPceo
 pTdVsZuPV5EImNo1HViJfFhyON+tFGgCieU9bm83b5mJGKmCi6kH5FsXh1HQvAMkkVSNhWQDB
 DMizJKqA/tSPknjAP97xLvGHgCM4QSQTq1HpI/J9Nla3r+wBkY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:06:16 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (9):
  Delete unnecessary code in user_init_raw_fds()
  Less checks in user_init_raw_fds() after error detection
  Adjust an error message in user_init_socket_fds()
  Delete an unnecessary check before kfree() in user_init_socket_fds()
  Delete two unnecessary checks before freeaddrinfo() in user_init_socket_fds()
  Less checks in user_init_socket_fds() after error detection
  Adjust an error message in user_init_tap_fds()
  Less checks in user_init_tap_fds() after error detection
  Delete an unnecessary variable initialisation in user_init_tap_fds()

 arch/um/drivers/vector_user.c | 133 +++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 73 deletions(-)

-- 
2.16.2
