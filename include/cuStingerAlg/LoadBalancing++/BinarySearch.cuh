/**
 * @author Federico Busato                                                  <br>
 *         Univerity of Verona, Dept. of Computer Science                   <br>
 *         federico.busato@univr.it
 * @date April, 2017
 * @version v2
 *
 * @copyright Copyright © 2017 cuStinger. All rights reserved.
 *
 * @license{<blockquote>
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 * * Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 * </blockquote>}
 *
 * @file
 */
#pragma once

#include "cuStingerAlg/TwoLevelQueue.cuh"

/**
 * @brief
 */
namespace load_balacing {

struct work_t {
    int*  first;
    int* second;

    void swap() noexcept;
};

__device__   int2   d_counters;
__constant__ work_t d_work;

class BinarySearch {
public:
    explicit BinarySearch(cu_stinger_alg::TwoLevelQueue<cu_stinger::id_t>& queue,
                          const cu_stinger::off_t* csr_offsets) noexcept;
    ~BinarySearch() noexcept;

    template<typename Operator, typename... TArgs>
    void traverse_edges(TArgs... optional_data) noexcept;
private:
    static const int         BLOCK_SIZE = 256;
    static const bool CHECK_CUDA_ERROR1 = 0;
    work_t _d_work;
    int    _total_work;
    cu_stinger_alg::TwoLevelQueue<cu_stinger::id_t>& _queue;
};

} // namespace load_balacing

#include "cuStingerAlg/LoadBalancing++/BinarySearch.i.cuh"
